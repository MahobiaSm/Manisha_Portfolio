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

Select * from MEDS;


