-- patients.ctl
LOAD DATA
INFILE 'patients.csv'
BADFILE 'patients.bad'
DISCARDFILE 'patients.dsc'
APPEND
INTO TABLE patients
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    patient_id,
    name,
    age,
    gender,
    blood_type
)
