from fastapi import Depends, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from jose import JWTError, jwt

from config import settings

secret = settings.secret_key
algo = "HS256"

security = HTTPBearer()


async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
):
    try:
        token = credentials.credentials

        payload = jwt.decode(token, secret, algorithms=[algo])

        return payload

    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid or expired token")


async def require_admin(user: dict = Depends(get_current_user)):
    if user is None:
        raise HTTPException(status_code=401, detail="Unauthorized !! User not provided")
    if user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Forbidden !! Admin role required")
    return user
