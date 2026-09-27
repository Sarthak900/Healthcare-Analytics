-- hospitals.ctl
LOAD DATA
INFILE 'hospitals.csv'
BADFILE 'hospitals.bad'
DISCARDFILE 'hospitals.dsc'
APPEND
INTO TABLE hospitals
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    hospital_id,
    hospital_name
)
