-- ============================================================
-- 01_schema.sql
-- Hospital Management API — Day 10 Assignment Schema
-- Tables: patients, doctors, appointments
-- Run this BEFORE 02_seed_data.sql if tables don't already exist.
-- ============================================================

CREATE TABLE IF NOT EXISTS patients (
    patient_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    mrn         TEXT    NOT NULL UNIQUE,
    name        TEXT    NOT NULL,
    age         INTEGER NOT NULL,
    ward        TEXT    NOT NULL,
    blood_group TEXT    NOT NULL,
    contact     TEXT,
    created_at  TEXT    DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS doctors (
    doctor_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name           TEXT    NOT NULL,
    specialization TEXT    NOT NULL,
    license_no     TEXT    NOT NULL UNIQUE,
    department     TEXT    NOT NULL,
    contact        TEXT,
    available      INTEGER NOT NULL DEFAULT 1,
    created_at     TEXT    DEFAULT (datetime('now'))
);

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
);
-- status values: 'scheduled' | 'confirmed' | 'completed' | 'cancelled'
