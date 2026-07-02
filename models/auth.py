import logging
import sqlite3
from datetime import datetime, timedelta

import yaml
from fastapi import HTTPException
from fastapi.security import HTTPBearer
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic import BaseModel

from config import settings

SECRET = settings.secret_key
ALGO = "HS256"
TOKEN_EXPIRY = settings.token_expiry

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

bearer_scheme = HTTPBearer

logger = logging.getLogger(__name__)

with open(r"sql\user.yaml") as f:
    queries = yaml.safe_load(f)


class RegisterReq(BaseModel):
    username: str
    password: str
    role: str
    doctor_id: int | None


class LoginReq(BaseModel):
    username: str
    password: str


class AuthService:
    @staticmethod
    async def register(db: sqlite3.Connection, user: RegisterReq):

        hashed_pass = pwd_context.hash(user.password)

        try:
            db.execute(
                queries["create_user"],
                (
                    user.username,
                    hashed_pass,
                    user.role,
                    user.doctor_id,
                ),
            )
            db.commit()

            return {"message": "User registered successfully"}
        except Exception as e:
            logger.exception(e)
            raise e

    @staticmethod
    async def login_user(db: sqlite3.Connection, user_data: LoginReq):
        try:
            user = db.execute(
                queries["get_user_by_username"], (user_data.username,)
            ).fetchone()
            if user is None:
                raise HTTPException(
                    status_code=404, detail=f"User {user_data.username} not found !!"
                )
            verify_pass = pwd_context.verify(user_data.password, user["password"])
            if not verify_pass:
                raise HTTPException(status_code=401, detail="Invalid credentials")

            payload = {
                "username": user_data.username,
                "role": user["role"],
                "doctor_id": user["doctor_id"],
                "exp": datetime.utcnow() + timedelta(minutes=TOKEN_EXPIRY),
            }

            token = jwt.encode(payload, SECRET, algorithm=ALGO)

            return {"token": token, "type": "bearer"}
        except Exception as e:
            logger.exception(e)
            raise e
