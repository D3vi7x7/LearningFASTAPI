import sqlite3

from fastapi import APIRouter, Depends

from db import getConnection
from models.appointment import Appointment, AppointmentService, AppointmentUpdate

router = APIRouter()


@router.post("")
async def create_appointment(
    appointment: Appointment, db: sqlite3.Connection = Depends(getConnection)
):
    resp = await AppointmentService.create(db, appointment)
    return resp


@router.get("/{patient_id}/visits")
async def get_patient_appointments(
    patient_id: int,
    status: str = None,
    doctor_id: int = None,
    department: str = None,
    from_date: str = None,
    to_date: str = None,
    db: sqlite3.Connection = Depends(getConnection),
):
    resp = await AppointmentService.get_patient_appointments(
        db, patient_id, status, doctor_id, department, from_date, to_date
    )
    return resp


@router.patch("/{appointment_id}")
async def update_appointment(
    appointment_id: int,
    appointment_data: AppointmentUpdate,
    db: sqlite3.Connection = Depends(getConnection),
):
    resp = await AppointmentService.update_appointment(
        db, appointment_id, appointment_data
    )
    return resp
