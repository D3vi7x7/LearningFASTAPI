import logging

from fastapi import FastAPI

from config import settings
from routers.appiontmentsRouter import router as appointments_router

logging.basicConfig(
    level=getattr(logging, settings.log_level.upper()),
    format="%(asctime)s | %(name)s | %(levelname)s | %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    handlers=[logging.StreamHandler(), logging.FileHandler(settings.log_file)],
)

app = FastAPI()

app.include_router(appointments_router, prefix="/appointments")
