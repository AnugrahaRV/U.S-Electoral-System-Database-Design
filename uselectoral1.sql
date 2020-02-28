-- Voter
CREATE TABLE voter (
voter_id  VARCHAR2(20) PRIMARY KEY,
ssn  INTEGER,
license_no  VARCHAR2(30),
first_name  CHAR(15),
last_name  CHAR(15),
citizenship  CHAR(1),
zipcode INTEGER,
registration_id VARCHAR2(20),
S_ID  VARCHAR(5)
);

-- Social Media
CREATE TABLE Social_Media (S_ID varchar(5) PRIMARY KEY,
username VARCHAR(50),
platform VARCHAR(10), 
no_of_followers INT,
count_of_comments INT,
post_type VARCHAR(10),
post_link VARCHAR(100),
date_of_post DATE,
part_or_individual VARCHAR(10));

-- Funds

CREATE TABLE Funds (fund_id VARCHAR(10) PRIMARY KEY,
party_id VARCHAR(10),
source_of_income VARCHAR(50), 
debited_amount INT,
credited_amount INT,
balance INT,
expense_description VARCHAR(50));


-- Campaigning_Events
CREATE TABLE Campaigning_Events  (event_id  VARCHAR(10) PRIMARY KEY, 
party_ID VARCHAR(10),
date_of_event DATE,
location VARCHAR(30),
type_of_event VARCHAR(40) ,
amount_used INT);


-- Party
Create table party
(party_id varchar(10) PRIMARY KEY,
party_name char(20),
treasurer_id VARCHAR(20)
);


-- Results
Create table results
(treasurer_id varchar(20) PRIMARY KEY,
results char(10) ,
vote_term INTEGER NOT NULL,
candidate_id varchar(10) NOT NULL,
registration_number varchar(20) NOT NULL,
bank_account varchar(20) NOT NULL,
tax_id varchar(20) NOT NULL,
event_id varchar(10) NOT NULL
);

-- Vote_detail
CREATE TABLE vote_detail (
    v_detail_id       INTEGER PRIMARY KEY,
    photo_id         CHAR(1),
    vote_date        DATE,
    vote_type        CHAR(20),
    voter_id     VARCHAR2(20) 
);

-- v_background_ck
CREATE TABLE v_background_ck (
    registration_id    VARCHAR2(20) PRIMARY KEY,
    state_id           VARCHAR2(25) NOT NULL,
    age INTEGER,
    country_of_birth  char(50) ,
    address_current    VARCHAR2(100) NOT NULL,
    address_past       VARCHAR2(100) NOT NULL,
felony_record CHAR(1)
);

-- felony_rc
CREATE TABLE felony_rc (
    felony_id VARCHAR2(20) PRIMARY KEY,
    currently_incarnated      CHAR(1),
    incarnation_period         INT,
    pardon_restored          CHAR(1),
voter_id VARCHAR2(20) 
);

-- candidate
Create table candidate
(candidate_id  varchar(30) PRIMARY KEY,
fname char(20) NOT NULL,
lname char(20) NOT NULL,
gender char(5) NOT NULL,
party_id  varchar(10) NOT NULL,
party char(20),
c_state char(20) ,
status char(20) NOT NULL,
dob date NOT NULL,
register_id  varchar(20) NOT NULL
);


-- c_background_check
CREATE TABLE c_background_check
   (	register_id  VARCHAR2(10), 
	candidate_id VARCHAR2(10 ) NOT NULL, 
	country_of_birth CHAR(20 ) NOT NULL, 
	assets VARCHAR2(20 ), 
	address VARCHAR2(100 ), 
	terms_served NUMBER(*,0) NOT NULL, 
	post CHAR(90 ), 
	yrs_of_residence NUMBER(2,0), 
	c_felony CHAR(5 ) NOT NULL, 
	 PRIMARY KEY (register_id)
    ) ;
   
-- house_rep
CREATE TABLE house_rep (
    rep_id VARCHAR2(20) PRIMARY KEY,
    rep_name CHAR(30),
    party_id VARCHAR2(25) NOT NULL,
    zipcode INTEGER NOT NULL,
    district CHAR(50),
    r_age INTEGER,
    r_yrs_of_ctzn INTEGER,
    r_state_add VARCHAR2(60),
    r_term INTEGER,
    state_id VARCHAR2(25),
    r_address VARCHAR2(100)
);

-- state
CREATE TABLE state (
state_id  VARCHAR2(25) PRIMARY KEY,
state_name CHAR(30)NOT NULL,
population INTEGER NOT NULL,
number_of_representatives INTEGER NOT NULL
);

-- senate
CREATE TABLE senate (
    senate_id VARCHAR2(20) PRIMARY KEY,
    senate_name CHAR(20)NOT NULL,
    party_id VARCHAR2(25) NOT NULL,
    s_age INTEGER NOT NULL,
    s_yrs_of_ctzn INTEGER NOT NULL,
    resident_state VARCHAR2(30) NOT NULL
);

-- state_senate
CREATE TABLE state_senate(
state_id VARCHAR2(25) NOT NULL,
senate_id VARCHAR2(20) NOT NULL);


SELECT * FROM  c_background_check;
SELECT * FROM  campaigning_events;
SELECT * FROM  candidate;
SELECT * FROM  felony_rc;
SELECT * FROM  funds;
SELECT * FROM  house_rep;
SELECT * FROM  party;
SELECT * FROM  results;
SELECT * FROM  senate;
SELECT * FROM  social_media;
SELECT * FROM  state;
SELECT * FROM  state_senate;
SELECT * FROM  v_background_ck;
SELECT * FROM  vote_detail;
SELECT * FROM  voter;


-- ALTER TABLES
ALTER TABLE Funds
ADD FOREIGN KEY (party_id) REFERENCES party(party_id);

ALTER TABLE Campaigning_Events
ADD FOREIGN KEY (party_id) REFERENCES party(party_id);

ALTER TABLE house_rep
ADD FOREIGN KEY (state_id) REFERENCES state(state_id);

ALTER TABLE state_senate
ADD FOREIGN KEY (state_id) REFERENCES state(state_id);

ALTER TABLE state_senate
ADD FOREIGN KEY (senate_id) REFERENCES senate(senate_id);

ALTER TABLE candidate
ADD FOREIGN KEY (party_id) REFERENCES party(party_id);

ALTER TABLE candidate
ADD FOREIGN KEY (register_id) REFERENCES c_background_check(register_id);

ALTER TABLE C_BACKGROUND_CHECK
ADD FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id);

ALTER TABLE party
ADD FOREIGN KEY (treasurer_id) REFERENCES results(treasurer_id);

ALTER TABLE voter
ADD FOREIGN KEY (registration_id) REFERENCES v_background_ck(registration_id);

ALTER TABLE voter
ADD FOREIGN KEY (s_id) REFERENCES Social_media(s_id);

ALTER TABLE vote_detail
ADD FOREIGN KEY (voter_id) REFERENCES voter(voter_id);

ALTER TABLE felony_rc
ADD FOREIGN KEY (voter_id) REFERENCES voter(voter_id);

-- VIEWS

CREATE VIEW voter_view AS
SELECT * FROM voter;

CREATE VIEW democratic_party_view AS
SELECT c.candidate_id,c.fname as "First name", c.lname as "Last Name",c.Gender,c.Party_id,c.c_state,c.dob,c.register_id,p.party_name,ce.date_of_event,ce.location,
ce.amount_used,ce.type_of_event
FROM candidate c, party p, campaigning_events ce
where c.party_id='D_01' OR p.party_id='D_01' OR ce.party_id='D_01' ;


CREATE VIEW independent_party_view AS
SELECT c.candidate_id,c.fname as "First name", c.lname as "Last Name",c.Gender,c.Party_id,c.c_state,c.dob,c.register_id,p.party_name,ce.date_of_event,ce.location,
ce.amount_used,ce.type_of_event
FROM candidate c, party p, campaigning_events ce
where c.party_id LIKE 'I%' OR p.party_id LIKE 'I%' OR ce.party_id LIKE 'I%' ;

-- DROP VIEW independent_party_view;

CREATE VIEW republic_party_view AS
SELECT c.candidate_id,c.fname as "First name", c.lname as "Last Name",c.Gender,c.Party_id,c.c_state,c.dob,c.register_id,p.party_name,ce.date_of_event,ce.location,
ce.amount_used,ce.type_of_event
FROM candidate c, party p, campaigning_events ce
where c.party_id='R_01' OR p.party_id='R_01' OR ce.party_id='R_01' ;

CREATE VIEW others_party_view AS
SELECT c.candidate_id,c.fname as "First name", c.lname as "Last Name",c.Gender,c.Party_id,c.c_state,c.dob,c.register_id,p.party_name,ce.date_of_event,ce.location,
ce.amount_used,ce.type_of_event
FROM candidate c, party p, campaigning_events ce
where c.party_id='O_01' OR p.party_id='O_01' OR ce.party_id='O_01' ;

CREATE VIEW candidate_view AS
SELECT c.candidate_id,c.fname as "First name", c.lname as "Last Name",c.Gender,c.Party_id,c.c_state,c.dob,c.register_id
FROM candidate c;

CREATE VIEW senate_view AS
SELECT * from senate;

CREATE VIEW representative_view AS
SELECT * from house_rep;

SELECT * FROM campaigning_events;

SELECT location,event_count FROM
(SELECT location,count(date_of_event) as event_count
FROM campaigning_events 
WHERE location NOT LIKE 'All%' 
GROUP BY location)
WHERE event_count > 1;

select b.first_name, b.last_name, a.registration_id from v_background_ck a join voter b 
on a.registration_id=b.registration_id  
where country_of_birth NOT IN ('United States') AND citizenship='Y' OR citizenship='y'
select b.first_name, b.last_name, a.registration_id from v_background_ck a join voter b 
on a.registration_id=b.registration_id  
where country_of_birth NOT IN ('United States') AND citizenship='N'
select * from v_background_ck where age<18;
select * from felony_rc;



select  b.first_name ||'is eligible to vote' from felony_rc a join voter b 
on a.voter_id= b.voter_id where b.voter_id like 'VT%'



select * from felony_rc where pardon_restored ='Y' AND pardon_restored IS NOT NULL 
UNION
select * from felony_rc where voter_id LIKE 'IO%';


select  b.first_name ||'is not eligible to vote' from felony_rc a join voter b 
on a.voter_id= b.voter_id where b.voter_id like 'AZ%'


select to_date('vote_date','03-Nov-2020')
from vote_detail;

select * from vote_detail;

select to_date(to_char('vote_date', 'DD-MON-YYYY'),'DD-MON-YYYY')-('03-NOV-2020','DD-MON-YYYY') as days
from vote_detail;

select months_between(TO_DATE(to_char('vote_date', 'DD-MON-YYYY'),'03-NOV-2020'))  from vote_detail;

select to_date(to_char('vote_date', 'DD-MON-YYYY'),'DD-MON-YYYY')-('03-NOV-2020','DD-MON-YYYY') as days
from vote_detail;

select * from candidate;
select * from c_background_check;
select *  from c_background_check where country_of_birth IN ('America');


SELECT CANDIDATE_ID, YRS_OF_RESIDENCE,
CASE 
    WHEN  YRS_OF_RESIDENCE >=14 THEN 'Eligible to contest'
    WHEN  YRS_OF_RESIDENCE < 14 THEN 'Not Eligible to contest'
END AS CONDITION
FROM C_BACKGROUND_CHECK;

select post FROM candidate 
where trunc(months_between(to_char('SYSDATE','DOB')/12)) >= 35;






select a.c_felony, a.candidate_id,b.fname,b.lname from C_BACKGROUND_CHECK a join candidate b
on a.candidate_id=b.candidate_id
where c_felony='Yes'

select CANDIDATE_ID, POST as C_POST, 
decode(terms_served,0,'Didnot serve',1,'Served once',2,'Served upto limit','na') 
as criteria from C_BACKGROUND_CHECK;

select * from party;
select results from results;

select a.party_name, b.results, b.vote_term from party a join results b
on a.treasurer_id = b.treasurer_id where b.results = 'Won';

select * from felony_rc;
SELECT voter_id, felony_id,
CASE 
    WHEN  pardon_restored ='Y' OR pardon_restored IS NULL THEN 'Eligible to VOTE'
    WHEN  pardon_restored ='N' OR pardon_restored IS NULL THEN  'Not Eligible to VOTE'

END AS CONDITION
FROM felony_rc where voter_id IS LIKE 'AZ%';

--CHECK FOR FUNDS BEFORE EVENTS
SELECT *
FROM funds f
FULL JOIN campaigning_events c
ON f.party_id = c.party_id
WHERE f.balance > c.amount_used;

-- population proportionality
with x as (select max (no_of_reps) as rep 
from
(select count(rep_id) no_of_reps, state_id
from house_rep 
group by state_id))
,
y as (select max(number_of_representatives) as maxrep
from state)
Select * 
from x, y
where rep < maxrep;


--a representative must be atleast 25years old
SELECT rep_name, r_age FROM house_rep
WHERE r_age >=25;

--a representative is less than 25 years old
SELECT rep_name, r_age FROM house_rep
WHERE r_age <=25;

--a senator must be atleast 30 years old
SELECT senate_name, s_age FROM senate
WHERE s_age >=30;


--a US citizen for atleast 7 years
SELECT rep_name, r_yrs_of_ctzn FROM house_rep
WHERE r_yrs_of_ctzn >= 7;

SELECT rep_name, r_yrs_of_ctzn FROM house_rep
WHERE r_yrs_of_ctzn <= 7;

--a US citizen for atleast 9 years
SELECT senate_name, s_yrs_of_ctzn FROM senate
WHERE s_yrs_of_ctzn >= 9;



