from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    db_path: str = "./hospital.db"
    app_title: str = "Appointment API"
    app_version: str = "1.0.0"
    log_level: str = "INFO"
    log_file: str = "./logs/hospital.log"
    secret_key: str = "It's a secret"
    token_expiry: int = 60  # in minutes

    model_config = SettingsConfigDict(
        env_file=".env", case_sensitive=False, extra="ignore"
    )


settings = Settings()
