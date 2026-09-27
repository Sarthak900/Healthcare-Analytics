-- admissions.ctl
LOAD DATA
INFILE 'admissions.csv'
BADFILE 'admissions.bad'
DISCARDFILE 'admissions.dsc'
APPEND
INTO TABLE admissions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    admission_id,
    patient_id,
    doctor_id,
    hospital_id,
    provider_id,
    medical_condition,
    date_of_admission DATE "YYYY-MM-DD",
    discharge_date DATE "YYYY-MM-DD",
    length_of_stay,
    admission_type,
    room_number,
    billing_amount,
    medication,
    test_results
)
