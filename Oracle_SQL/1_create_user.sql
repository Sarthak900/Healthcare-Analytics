CREATE USER Hospital_analytics IDENTIFIED BY "Your_Password_here"
DEFAULT TABLESPACE USERS;

GRANT CREATE SESSION TO Hospital_analytics;
GRANT CREATE TABLE TO Hospital_analytics;
GRANT CREATE SEQUENCE TO Hospital_analytics;
GRANT CREATE TRIGGER TO Hospital_analytics;
GRANT CREATE VIEW TO Hospital_analytics;
GRANT UNLIMITED TABLESPACE TO Hospital_analytics;