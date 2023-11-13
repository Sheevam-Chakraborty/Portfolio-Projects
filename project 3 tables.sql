CREATE DATABASE Project3;
SHOW DATABASES;
USE project3;

#Table-1 users

CREATE TABLE users (
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM USERS;

#created_at type change

ALTER TABLE users ADD COLUMN temp_created_at datetime;

UPDATE users SET temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');

ALTER TABLE users DROP COLUMN temp_occured_at;

ALTER TABLE users CHANGE column temp_created_at created_at DATETIME;

#activated_at type change

ALTER TABLE users ADD COLUMN temp_activated_at datetime;

UPDATE users SET temp_activated_at = str_to_date(activated_at, '%d-%m-%Y %H:%i');

ALTER TABLE users DROP COLUMN activated_at;

ALTER TABLE users CHANGE column temp_activated_at activated_at DATETIME;


#Table-2 events

CREATE TABLE events (
user_id int,
occured_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM events;
drop table events;

#occured_at type change

ALTER TABLE events ADD COLUMN temp_occured_at datetime;

UPDATE events SET temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

ALTER TABLE events DROP COLUMN occured_at;

ALTER TABLE events CHANGE column temp_occured_at occured_at DATETIME;


#Table-3 email_events

CREATE TABLE email_events (
user_id int,
occured_at varchar(100),
action varchar(100),
user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from email_events;

#occured_at type change

ALTER TABLE email_events ADD COLUMN temp_occured_at datetime;

UPDATE email_events SET temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

ALTER TABLE email_events DROP COLUMN occured_at;

ALTER TABLE email_events CHANGE column temp_occured_at occured_at DATETIME;


#Table-4 job_data

CREATE TABLE job_data (
ds varchar(100),
job_id int,
actor_id int,
event varchar(100),
language varchar(100),
time_spent int,
org varchar(50)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data.csv"
INTO TABLE job_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM job_data;

#ds change data type

ALTER TABLE job_data ADD COLUMN temp_ds DATETIME;

UPDATE job_data SET temp_ds = STR_TO_DATE(ds, '%m/%d/%Y');

ALTER TABLE job_data DROP COLUMN ds;

ALTER TABLE job_data CHANGE COLUMN temp_ds ds DATETIME;
