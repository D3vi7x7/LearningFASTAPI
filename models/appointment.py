import logging
import sqlite3
from typing import Any, Optional

import yaml
from pydantic import BaseModel, Field
from starlette.exceptions import HTTPException

logger = logging.getLogger(__name__)  # The logger

# getting queries
with open(r"sql\appointment.yaml") as f:
    queries = yaml.safe_load(f)

with open(r"sql\patient.yaml") as f:
    patient_queries = yaml.safe_load(f)

with open(r"sql\doctor.yaml") as f:
    doctor_queries = yaml.safe_load(f)


# pydantic models
class Appointment(BaseModel):
    patient_id: int
    doctor_id: int
    appointment_date: str
    appointment_time: str
    status: str = "scheduled"
    notes: Optional[str] = None
    diagnosis: Optional[str] = None


class AppointmentUpdate(BaseModel):
    appointment_date: Optional[str] = None
    appointment_time: Optional[str] = None
    status: Optional[str] = None
    notes: Optional[str] = None
    diagnosis: Optional[str] = None


class AppointmentService:
    @staticmethod
    async def create(db: sqlite3.Connection, appointment: Appointment):
        try:
            patient = db.execute(
                patient_queries["get_patient_by_id"], (appointment.patient_id,)
            )
            doctor = db.execute(
                doctor_queries["get_doctor_by_id"], (appointment.doctor_id,)
            )

            if patient is None:
                raise HTTPException(status_code=404, detail="patient not found !!")

            if doctor is None:
                raise HTTPException(status_code=404, detail="doctor not found !!")

            db.execute(
                queries["create_appointment"],
                (
                    appointment.patient_id,
                    appointment.doctor_id,
                    appointment.appointment_date,
                    appointment.appointment_time,
                    appointment.status,
                    appointment.notes,
                    appointment.diagnosis,
                ),
            )

            db.commit()

            logger.info(f"Appointment created for patient {appointment.patient_id} !!")

            return {"message": "appointment created successfully !!"}
        except Exception as e:
            logger.exception(e)
            raise e

    @staticmethod
    async def get_patient_appointments(
        db: sqlite3.Connection,
        patient_id: int,
        status: str = None,
        doctor_id: int = None,
        department: str = None,
        from_date: str = None,
        to_date: str = None,
    ):
        try:
            query = queries["get_patient_visits"]
            params: dict[str, Any] = {"patient_id": patient_id}

            if status:
                query += " AND a.status = :status"
                params["status"] = status
            if doctor_id:
                query += " AND a.doctor_id = :doctor_id"
                params["doctor_id"] = doctor_id
            if department:
                query += " AND d.department = :department"
                params["department"] = department
            if from_date:
                query += " AND a.appointment_date >= :from_date"
                params["from_date"] = from_date
            if to_date:
                query += " AND a.appointment_date <= :to_date"
                params["to_date"] = to_date
            # breakpoint()
            res = db.execute(query, params).fetchall()

            logger.info(f"Fetched {len(res)} appointments")

            return [dict(row) for row in res]
        except Exception as e:
            logger.exception(e)
            raise e

    @staticmethod
    async def update_appointment(
        db: sqlite3.Connection, appointment_id: int, appointment_data: AppointmentUpdate
    ):
        try:
            updates = []
            values = []

            for key, value in appointment_data.model_dump(exclude_none=True).items():
                updates.append(f"{key} = :{key}")
                values.append(value)

            query = queries["update_appointment"].format(fields=", ".join(updates))
            values.append(appointment_id)

            db.execute(query, tuple(values))
            db.commit()

            row = db.execute(queries["get_by_id"], (appointment_id,)).fetchone()

            logger.info(f"Appointment updated for {appointment_id}")

            return dict(row)
        except Exception as e:
            logger.exception(e)
            raise e
