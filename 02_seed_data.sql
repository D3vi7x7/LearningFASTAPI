-- ============================================================
-- 02_seed_data.sql
-- Hospital Management API — Day 10 Assignment Seed Data
-- 10 doctors, 14 patients, 50 appointments (Dec 2025 – Jun 2026)
-- Run AFTER 01_schema.sql. Safe to re-run (DELETEs first).
-- ============================================================

DELETE FROM appointments;
DELETE FROM doctors;
DELETE FROM patients;

-- ─── DOCTORS (doctor_id 1-10, in insertion order) ───────────
INSERT INTO doctors (name, specialization, license_no, department, contact, available) VALUES
  ('Dr. Priya Sharma', 'Cardiology', 'LIC-CAR-001', 'Cardiology', '9900001111', 1),
  ('Dr. Rohit Mehta', 'Cardiology', 'LIC-CAR-002', 'Cardiology', '9900002222', 1),
  ('Dr. Anjali Verma', 'Neurology', 'LIC-NEU-003', 'Neurology', '9900003333', 1),
  ('Dr. Suresh Patel', 'Orthopaedics', 'LIC-ORT-004', 'Orthopaedics', '9900004444', 1),
  ('Dr. Kavitha Nair', 'Paediatrics', 'LIC-PAE-005', 'Paediatrics', '9900005555', 1),
  ('Dr. Ramesh Iyer', 'General Medicine', 'LIC-GEN-006', 'General Medicine', '9900006666', 1),
  ('Dr. Deepa Krishnan', 'Dermatology', 'LIC-DER-007', 'Dermatology', '9900007777', 1),
  ('Dr. Arun Kumar', 'Orthopaedics', 'LIC-ORT-008', 'Orthopaedics', '9900008888', 0),
  ('Dr. Meera Singh', 'Neurology', 'LIC-NEU-009', 'Neurology', '9900009999', 1),
  ('Dr. Vikram Rajan', 'General Medicine', 'LIC-GEN-010', 'General Medicine', '9900010000', 1);

-- ─── PATIENTS (patient_id 1-14, in insertion order) ─────────
INSERT INTO patients (mrn, name, age, ward, blood_group, contact) VALUES
  ('MRN-1001', 'Ravi Kumar', 45, 'ICU', 'A+', '8800001111'),
  ('MRN-1002', 'Sunita Sharma', 62, 'General', 'O+', '8800002222'),
  ('MRN-1003', 'Arjun Patel', 34, 'General', 'B+', '8800003333'),
  ('MRN-1004', 'Meena Iyer', 55, 'General', 'AB+', '8800004444'),
  ('MRN-1005', 'Kartik Mehta', 28, 'General', 'O-', '8800005555'),
  ('MRN-1006', 'Preethi Nair', 40, 'ICU', 'A-', '8800006666'),
  ('MRN-1007', 'Sanjay Gupta', 67, 'General', 'B+', '8800007777'),
  ('MRN-1008', 'Lakshmi Devi', 52, 'General', 'O+', '8800008888'),
  ('MRN-1009', 'Rahul Verma', 31, 'General', 'A+', '8800009999'),
  ('MRN-1010', 'Anita Krishnan', 48, 'ICU', 'AB-', '8800010000'),
  ('MRN-1011', 'Mohan Das', 73, 'General', 'O+', '8800011111'),
  ('MRN-1012', 'Pooja Reddy', 25, 'General', 'B-', '8800012222'),
  ('MRN-1013', 'Deepak Rao', 58, 'ICU', 'B+', '8800013333'),
  ('MRN-1014', 'Lalitha Iyer', 65, 'General', 'AB+', '8800014444');

-- ─── APPOINTMENTS (50 rows) ──────────────────────────────────
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes, diagnosis) VALUES
  -- Patient 1: Ravi Kumar
  (1, 1, '2025-12-10', '09:00', 'completed', 'Chest tightness, breathlessness on exertion', 'Hypertension Stage 2'),
  (1, 1, '2026-01-15', '09:00', 'completed', 'BP at 150/95, medication review', 'BP partially controlled, dosage increased'),
  (1, 1, '2026-03-05', '10:00', 'completed', 'Routine ECG and stress test', 'ECG normal, stress test borderline positive'),
  (1, 1, '2026-05-20', '09:30', 'completed', 'Pre-angiography evaluation, consent', 'Cleared for procedure'),
  (1, 2, '2026-06-15', '11:00', 'confirmed', 'Post-procedure check', ''),
  -- Patient 2: Sunita Sharma
  (2, 6, '2026-01-08', '10:00', 'completed', 'Excessive thirst, frequent urination, fatigue', 'Type 2 Diabetes Mellitus'),
  (2, 6, '2026-02-20', '10:30', 'completed', 'Blood sugar follow-up, HbA1c review', 'FBS 140 mg/dl, medication effective'),
  (2, 3, '2026-04-12', '14:00', 'completed', 'Severe headache, visual disturbances', 'Migraine with aura'),
  (2, 6, '2026-06-01', '10:00', 'completed', 'HbA1c result 6.8, energy improved', 'Diabetes well-controlled'),
  (2, 6, '2026-06-25', '10:00', 'scheduled', '', ''),
  -- Patient 3: Arjun Patel
  (3, 4, '2026-02-14', '11:00', 'completed', 'Right knee pain after football injury', 'Grade 2 ACL Tear'),
  (3, 4, '2026-03-20', '11:30', 'completed', 'Post-physiotherapy review', 'Good improvement, 60% recovery'),
  (3, 8, '2026-05-10', '14:00', 'completed', 'Second opinion on surgery requirement', 'Arthroscopic surgery recommended'),
  (3, 8, '2026-06-18', '09:00', 'completed', 'Pre-surgery assessment, consent signed', 'Fit for arthroscopy'),
  -- Patient 4: Meena Iyer
  (4, 6, '2026-01-20', '09:00', 'completed', 'Fatigue, weight gain, hair loss', 'Hypothyroidism'),
  (4, 6, '2026-03-15', '09:30', 'completed', 'TSH levels review, 3 months on Levothyroxine', 'TSH normalised'),
  (4, 3, '2026-06-10', '15:00', 'completed', 'Memory lapses, difficulty concentrating', 'Mild cognitive changes, age-related, no pathology'),
  -- Patient 5: Kartik Mehta
  (5, 7, '2026-04-05', '12:00', 'completed', 'Itchy red patches on arms and neck since 2 weeks', 'Atopic Eczema'),
  (5, 7, '2026-05-08', '12:00', 'completed', 'Patches reducing, itching less severe', 'Eczema controlled on topical steroid'),
  (5, 7, '2026-06-19', '12:30', 'confirmed', 'Maintenance review', ''),
  -- Patient 6: Preethi Nair
  (6, 1, '2025-11-30', '10:00', 'completed', 'Sharp chest pain on deep breathing', 'Costochondritis'),
  (6, 6, '2026-01-25', '11:00', 'completed', 'Weakness, pallor, dizziness for 2 weeks', 'Iron Deficiency Anaemia'),
  (6, 6, '2026-06-05', '11:30', 'completed', 'Haemoglobin check, feels better', 'Hb 11.8 g/dl, improving on iron supplements'),
  -- Patient 7: Sanjay Gupta
  (7, 3, '2025-12-20', '09:00', 'completed', 'Sudden left arm weakness, slurred speech for 20 min', 'Transient Ischaemic Attack (TIA)'),
  (7, 3, '2026-02-10', '09:00', 'completed', 'Follow-up MRI brain, blood thinner review', 'No infarct on MRI, antiplatelet continued'),
  (7, 3, '2026-04-20', '09:30', 'completed', 'Quarterly neurological assessment', 'Stable, no new TIA episodes'),
  (7, 9, '2026-06-12', '14:00', 'completed', 'Second opinion, concern about current medication', 'Confirms TIA management, switched to Clopidogrel'),
  (7, 3, '2026-06-30', '09:00', 'scheduled', '', ''),
  -- Patient 8: Lakshmi Devi
  (8, 6, '2026-03-08', '10:00', 'completed', 'Right knee pain, incidental BP elevation', 'Osteoarthritis Grade 1, Hypertension Stage 1'),
  (8, 4, '2026-05-15', '11:00', 'completed', 'Ortho referral, right knee X-ray done', 'Grade 1 osteoarthritis, physiotherapy advised'),
  (8, 4, '2026-06-08', '11:30', 'confirmed', 'Physiotherapy progress check', ''),
  -- Patient 9: Rahul Verma
  (9, 10, '2026-05-22', '16:00', 'completed', 'Calf muscle tear during cricket match', 'Grade 2 Muscle Strain'),
  (9, 10, '2026-06-17', '16:00', 'completed', 'Full recovery assessment', 'Cleared for return to sport'),
  -- Patient 10: Anita Krishnan
  (10, 1, '2026-02-28', '10:00', 'completed', 'Palpitations, irregular heartbeat for 1 week', 'Paroxysmal Atrial Fibrillation'),
  (10, 1, '2026-04-08', '10:30', 'completed', 'Holter monitor 24hr results review', 'AF controlled on Bisoprolol 5mg'),
  (10, 2, '2026-06-02', '11:00', 'completed', 'Treadmill stress test, cardio clearance', 'Normal sinus rhythm under stress'),
  (10, 1, '2026-06-20', '10:00', 'scheduled', '', ''),
  -- Patient 11: Mohan Das
  (11, 6, '2025-12-15', '09:00', 'completed', 'Uncontrolled DM, HbA1c 10.2%, skin infections', 'Type 2 DM - poor glycaemic control'),
  (11, 6, '2026-01-30', '09:30', 'completed', 'Oral meds ineffective, switching to insulin', 'Insulin therapy initiated, fasting sugar 190'),
  (11, 3, '2026-03-25', '14:30', 'completed', 'Tingling and numbness in both feet and hands', 'Diabetic Peripheral Neuropathy'),
  (11, 6, '2026-05-28', '09:00', 'completed', 'HbA1c now 7.2%, foot examination normal', 'Good glycaemic improvement on insulin'),
  (11, 6, '2026-06-18', '09:00', 'completed', 'Quarterly review, neuropathy symptoms reduced', 'Stable, continue current regimen'),
  -- Patient 12: Pooja Reddy
  (12, 7, '2026-05-10', '13:00', 'completed', 'Acne, oily skin, post-acne dark spots', 'Acne Vulgaris Grade 2'),
  (12, 7, '2026-06-14', '13:00', 'completed', 'Skin texture improving, dark spots fading', 'Improving on tretinoin and niacinamide'),
  -- Patient 13: Deepak Rao
  (13, 1, '2026-05-05', '09:00', 'completed', 'Recurring chest pain on exertion, 3 weeks', 'Stable Angina'),
  (13, 2, '2026-06-03', '10:00', 'completed', 'Angiogram result review with cardiologist', 'Single vessel CAD, stenting planned'),
  (13, 2, '2026-06-22', '09:00', 'scheduled', '', ''),
  -- Patient 14: Lalitha Iyer
  (14, 6, '2026-02-18', '11:00', 'completed', 'Chest discomfort after meals, breathlessness on stairs', 'GERD, Hypertension Stage 1'),
  (14, 6, '2026-04-30', '11:30', 'completed', 'BP well controlled, acid reflux improving on PPI', 'BP 130/82, GERD controlled'),
  (14, 6, '2026-06-16', '11:00', 'completed', 'Routine review, no new complaints', 'Stable on current medications');
