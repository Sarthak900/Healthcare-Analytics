-- insurance_providers.ctl
LOAD DATA
INFILE 'insuranceproviders.csv'
BADFILE 'insurance_providers.bad'
DISCARDFILE 'insurance_providers.dsc'
APPEND
INTO TABLE insurance_providers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    provider_id,
    provider_name
)
