-- doctors.ctl
LOAD DATA
INFILE 'doctors.csv'
BADFILE 'doctors.bad'
DISCARDFILE 'doctors.dsc'
APPEND
INTO TABLE doctors
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    doctor_id,
    doctor_name
)
