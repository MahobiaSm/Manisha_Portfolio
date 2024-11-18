-- Create Medicare Database

USE [master]
GO

CREATE DATABASE [Medicare]
 
-- Connect to Medicare Database
Use Medicare


-- Create Table Patients
Create Table Patients
(
PatientID int Primary Key,
PatientNO int,
Initials varchar (10)
) 

-- Insert Statements For Patients
Insert into Patients
values (1, 1, 'ABC'),
	   (2, 3, 'DEF'),
	   (3, 4, 'HIJ')

Select * from Patients



-- Create Table Visits
Create Table Visits
(
VisitID int Primary Key, 
VPatientsID int References Patients(PatientID),
VisitNO int, 
VisitDate Date Default GETDATE(),
) 

-- Insert Statements For Visits

Insert into Visits
values (1, 1, 1, '2018-01-06'),
	   (2, 1, 2, '2018-02-17'),
	   (3, 1, 3, '2018-03-17'),
	   (4, 2, 1, '2018-04-17'),
	   (5, 2, 2, '2018-05-17'),
	   (6, 3, 1, '2018-06-17'),
	   (7, 3, 2, '2018-07-17')
	    
Select * from Visits


-- Create Table Vital Signs
Create Table Vitals
(
VisitID int References Visits(VisitID), 
Systolic int,
Diastolic int,
) 

-- Insert Statements For Vital Signs
Insert into Vitals
values (1, 120, 80),
	   (2, 125, 84),
	   (3, 130, 90),
	   (4, 145, 101),
	   (5, 139, 96),
	   (6, 142, 97),
	   (7, 145, 100)

Select * from Vitals



-- Create Table Adverse Events
Create Table AES
(
VisitID int References Visits(VisitID),
AE Varchar(30),
Med Varchar(30),
)



-- Insert Statements For Adverse Events
Insert into AES (VisitID, AE, Med) values(1, 'Headache', 'Asprin')
Insert into AES (VisitID, AE) values (1, 'Nausea')
Insert into AES (VisitID, AE, Med) values (3, 'Headache', 'Tylenol')
Insert into AES (VisitID, AE) values (4, 'High BP')
Insert into AES (VisitID, AE, Med) values (4, 'Heartburn', 'Zantac')
Insert into AES (VisitID, AE, Med) values (7, 'High BP', 'Norvasc')

Select * from AES 
	
-- Create Table Medications
Create Table MEDS
(
VisitID int References Visits(VisitID),
Med Varchar(30),
MedDate date,
TakenFor Varchar(30)
) 

-- Insert Statements For Medications
Insert into MEDS(VisitID, Med, MedDate) Values (1, 'Asprin', '11-01-2005')
Insert into MEDS(VisitID, Med, MedDate) Values (3, 'Tylenol', '07-01-2005')
Insert into MEDS(VisitID, Med, MedDate) Values (4, 'Zantac', '01-02-2005')
Insert into MEDS(VisitID, Med, MedDate) Values (6, 'Aleve', '01-02-2005')

Select * from MEDS



/*#1.
1.	Write SQL Query to produce the following report on the vital signs data.
 Order by patient number and visit number.
PatientNo        VisitNo        VisitDate        Systolic        Diastolic

*/

Select P.PatientNo, VS.VisitNo, VS.VisitDate, VT.Systolic, VT.Diastolic
from VITALS as VT
INNER JOIN VISITS as VS
ON VS.[VISITID] = VT.[VISITID]
INNER JOIN PATIENTS as P
ON VS.VPatientsID = P.PatientId





/*
2.	List the patient number and initials for every patient that never had a headache
-- NESTED SUB QUERY
*/
select PatientNO, Initials 
from Patients  
where 
PatientID not in 
				(
				select VPatientsID from visits V inner join Vitals VS
				on V.VisitID=VS.VisitID 
				where 
				VS.VisitID in
									(
									select VisitID from AES where AE='Headache'
									)
				 )




/*
3.	Produce the following report, showing each adverse event and the details of the medication taken for 
that adverse event. Include all adverse events, even those for which no medication was taken.
PatientNo                AE                Med                        MedDate

*/

Select PatientNO, AE, AES.Med, MedDate from AES 
LEFT OUTER JOIN VISITS 
ON VISITS.VISITID = AES.VISITID
INNER JOIN PATIENTS
ON  VISITS.VPatientsID = PATIENTS.PatientId
LEFT OUTER JOIN MEDS
ON MEDS.VisitId = VISITS.VisitId




/*
4.	List the distinct set of medications taken in the study. 
-- Beware – this is not as trivial as it looks. Extra credit for being careful.
*/

Select distinct Med from AES where len(Med) > 0 
UNION 
Select distinct Med from MEDS where len(Med) > 0 ;


Select distinct Med from AES  
UNION 
Select distinct Med from MEDS ;




/*
5.	List the average systolic blood pressure (Sys) for all patients who ever had an adverse event of “High BP”
*/

Select avg(Systolic)
from VITALS 
INNER JOIN AES 
ON AES.visitid = VITALS.visitid
where AES.AE ='High BP';




/*
6. List all patients who had a headache more than once
*/

Select * from PATIENTS 
where PatientNo in 
		(
		Select PATIENTS.PatientNo 
		from AES 
		INNER JOIN VISITS
		ON AES.VISITId = VISITS.VISITID
		INNER JOIN PATIENTS
		ON VISITS.VPatientsID = PATIENTS.PatientId
		where AES.AE ='Headache'
		group by PATIENTS.PatientNo
		having count(*) > 1
		);



-- ATTENDEES FOR T-SQL PLAN A, BI COURSES	:  YOU SHALL BE GIVEN ADDITIONAL LIST OF QUERIES FOR PRACTICE
-- ATTENDEES FOR T-SQL PLAN B				:  YOU SHALL USE THESE QUERIES FOR PROGRAMMING CONCPETS NEXT. 
-- ATTENDEES FOR SQL DBA					:  YOU SHALL GIVE TUNING RECOMMENDATIONS FOR EACH OF THE ABVOE QUERY.


