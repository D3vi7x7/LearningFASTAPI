import sqlite3

from fastapi import APIRouter, Depends

from db import getConnection
from models.auth import AuthService, LoginReq, RegisterReq

router = APIRouter()


@router.post("/register")
async def register(user: RegisterReq, db: sqlite3.Connection = Depends(getConnection)):
    resp = await AuthService.register(db, user)
    return resp


@router.post("/login")
async def login(user: LoginReq, db: sqlite3.Connection = Depends(getConnection)):
    resp = await AuthService.login_user(db, user)
    return resp
