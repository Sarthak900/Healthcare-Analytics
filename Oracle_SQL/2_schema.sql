
-- Drop existing objects (ignore errors if they don't exist yet)
DROP TABLE admissions CASCADE CONSTRAINTS;
DROP TABLE patients CASCADE CONSTRAINTS;
DROP TABLE doctors CASCADE CONSTRAINTS;
DROP TABLE hospitals CASCADE CONSTRAINTS;
DROP TABLE insurance_providers CASCADE CONSTRAINTS;
DROP SEQUENCE doctors_seq;
DROP SEQUENCE hospitals_seq;
DROP SEQUENCE providers_seq;
DROP SEQUENCE patients_seq;

-- ------------------------------------------------------------
-- Dimension: Doctors
-- ------------------------------------------------------------
CREATE TABLE doctors (
    doctor_id   NUMBER PRIMARY KEY,
    doctor_name VARCHAR2(200) UNIQUE NOT NULL
);
CREATE SEQUENCE doctors_seq START WITH 40342 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER doctors_bi
BEFORE INSERT ON doctors
FOR EACH ROW
WHEN (NEW.doctor_id IS NULL)
BEGIN
    SELECT doctors_seq.NEXTVAL INTO :NEW.doctor_id FROM dual;
END;
/

-- ------------------------------------------------------------
-- Dimension: Hospitals
-- ------------------------------------------------------------
CREATE TABLE hospitals (
    hospital_id   NUMBER PRIMARY KEY,
    hospital_name VARCHAR2(300) UNIQUE NOT NULL
);
CREATE SEQUENCE hospitals_seq START WITH 39877 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER hospitals_bi
BEFORE INSERT ON hospitals
FOR EACH ROW
WHEN (NEW.hospital_id IS NULL)
BEGIN
    SELECT hospitals_seq.NEXTVAL INTO :NEW.hospital_id FROM dual;
END;
/

-- ------------------------------------------------------------
-- Dimension: Insurance Providers
-- ------------------------------------------------------------
CREATE TABLE insurance_providers (
    provider_id   NUMBER PRIMARY KEY,
    provider_name VARCHAR2(200) UNIQUE NOT NULL
);
CREATE SEQUENCE providers_seq START WITH 6 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER providers_bi
BEFORE INSERT ON insurance_providers
FOR EACH ROW
WHEN (NEW.provider_id IS NULL)
BEGIN
    SELECT providers_seq.NEXTVAL INTO :NEW.provider_id FROM dual;
END;
/

-- ------------------------------------------------------------
-- Dimension: Patients
-- ------------------------------------------------------------
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY,
    name       VARCHAR2(200) NOT NULL,
    age        NUMBER(3) NOT NULL,
    gender     VARCHAR2(20) NOT NULL,
    blood_type VARCHAR2(5) NOT NULL
);
CREATE SEQUENCE patients_seq START WITH 54945 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER patients_bi
BEFORE INSERT ON patients
FOR EACH ROW
WHEN (NEW.patient_id IS NULL)
BEGIN
    SELECT patients_seq.NEXTVAL INTO :NEW.patient_id FROM dual;
END;
/

-- ------------------------------------------------------------
-- Fact table: Admissions (one row per hospital visit)

-- ------------------------------------------------------------
CREATE TABLE admissions (
    admission_id       NUMBER PRIMARY KEY,
    patient_id         NUMBER NOT NULL REFERENCES patients(patient_id),
    doctor_id          NUMBER NOT NULL REFERENCES doctors(doctor_id),
    hospital_id        NUMBER NOT NULL REFERENCES hospitals(hospital_id),
    provider_id        NUMBER NOT NULL REFERENCES insurance_providers(provider_id),
    medical_condition  VARCHAR2(100) NOT NULL,
    date_of_admission  DATE NOT NULL,
    discharge_date      DATE NOT NULL,
    length_of_stay     NUMBER(5) NOT NULL,
    admission_type     VARCHAR2(20) NOT NULL,   -- Emergency / Elective / Urgent
    room_number        NUMBER(6) NOT NULL,
    billing_amount     NUMBER(10,2) NOT NULL,
    medication         VARCHAR2(100) NOT NULL,
    test_results        VARCHAR2(20) NOT NULL    -- Normal / Abnormal / Inconclusive
);

CREATE INDEX idx_admissions_date ON admissions(date_of_admission);
CREATE INDEX idx_admissions_doctor ON admissions(doctor_id);
CREATE INDEX idx_admissions_hospital ON admissions(hospital_id);
CREATE INDEX idx_admissions_provider ON admissions(provider_id);

COMMIT;















