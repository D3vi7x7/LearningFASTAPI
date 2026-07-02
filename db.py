import sqlite3

from config import settings


def initDB():
    conn = sqlite3.connect(settings.db_path, check_same_thread=False)
    conn.row_factory = sqlite3.Row

    conn.execute("""
        CREATE TABLE IF NOT EXISTS patients (
            patient_id  INTEGER PRIMARY KEY AUTOINCREMENT,
            mrn         TEXT    NOT NULL UNIQUE,
            name        TEXT    NOT NULL,
            age         INTEGER NOT NULL,
            ward        TEXT    NOT NULL,
            blood_group TEXT    NOT NULL,
            contact     TEXT,
            created_at  TEXT    DEFAULT (datetime('now'))
        )
    """)

    conn.execute("""
        CREATE TABLE IF NOT EXISTS doctors (
            doctor_id      INTEGER PRIMARY KEY AUTOINCREMENT,
            name           TEXT    NOT NULL,
            specialization TEXT    NOT NULL,
            license_no     TEXT    NOT NULL UNIQUE,
            department     TEXT    NOT NULL,
            contact        TEXT,
            available      INTEGER NOT NULL DEFAULT 1,
            created_at     TEXT    DEFAULT (datetime('now'))
        )
    """)

    conn.execute("""
        CREATE TABLE IF NOT EXISTS appointments (
            appointment_id   INTEGER PRIMARY KEY AUTOINCREMENT,
            patient_id       INTEGER NOT NULL REFERENCES patients(patient_id),
            doctor_id        INTEGER NOT NULL REFERENCES doctors(doctor_id),
            appointment_date TEXT    NOT NULL,
            appointment_time TEXT    NOT NULL DEFAULT '10:00',
            status           TEXT    NOT NULL DEFAULT 'scheduled',
            notes            TEXT             DEFAULT '',
            diagnosis        TEXT             DEFAULT '',
            created_at       TEXT             DEFAULT (datetime('now'))
        )
    """)

    conn.commit()


def getConnection():
    conn = sqlite3.connect(settings.db_path, check_same_thread=False)

    conn.row_factory = sqlite3.Row

    try:
        yield conn
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        conn.close()
