CREATE DATABASE Student_Management_System;
USE Student_Management_System;

-- Department Table 

CREATE TABLE Department (
	dept_ID int AUTO_INCREMENT,
    dept_Name varchar(50) NOT NULL,
    PRIMARY KEY(dept_ID)
);

DESC Department;

-- Student Table 

CREATE TABLE Student (
	std_ID varchar(20),
    std_fName varchar(30) NOT NULL,
    std_midName varchar(30) NOT NULL,
    std_lName varchar(30) NOT NULL,
    std_dept int NOT NULL,
    std_contactNo varchar(10) NOT NULL,
    std_birthDate date NOT NULL,
    std_emailID varchar(50),
    std_age int,
    std_gender varchar(1) NOT NULL,
    std_houseName varchar(30) NOT NULL,
    std_streetName varchar(30) NOT NULL,
    std_city varchar(30) NOT NULL,
    std_state varchar(30) NOT NULL,
    std_pincode varchar(6) NOT NULL,
    std_fatherName varchar(50),
    std_motherName varchar(50),
    PRIMARY KEY(std_ID),
    FOREIGN KEY(std_dept) REFERENCES Department(dept_ID)
); 

-- Validations - Student Table 

-- Default ID 

ALTER TABLE `Student` 
ALTER std_ID SET DEFAULT('AUYY00000');

-- Contact number validation 

ALTER TABLE `Student`
ADD CONSTRAINT `stdContactVal`
CHECK (std_contactNo REGEXP '^[1-9][0-9]{9}$'); 

-- Email address validation 

ALTER TABLE `Student`
ADD CONSTRAINT `stdEmailVal`
CHECK (std_emailID REGEXP '@ahduni.edu.in$');

-- Gender validation 

ALTER TABLE `Student`
ADD CONSTRAINT `stdGenderVal`
CHECK (std_gender = 'm' OR std_gender = 'M' OR std_gender = 'f' OR std_gender = 'F');

-- Pincode validation 

ALTER TABLE `Student` 
ADD CONSTRAINT `stdPincodeVal`
CHECK (std_pinCode REGEXP '[0-9]{6}');

DESC Student;

-- Instructor Table 

CREATE TABLE Instructor (
	inst_ID varchar(5),
    inst_fName varchar(30) NOT NULL,
    inst_midName varchar(30) NOT NULL,
    inst_lName varchar(30) NOT NULL,
    inst_dept int NOT NULL,
    inst_contactNo varchar(10) NOT NULL,
    inst_birthDate date NOT NULL,
    inst_emailID varchar(50) NOT NULL,
    inst_age int,
    inst_gender varchar(1) NOT NULL,
    inst_houseName varchar(30) NOT NULL,
    inst_streetName varchar(30) NOT NULL,
    inst_city varchar(30) NOT NULL,
    inst_state varchar(30) NOT NULL,
    inst_pincode varchar(6) NOT NULL,
    PRIMARY KEY(inst_ID),
    FOREIGN KEY(inst_dept) REFERENCES Department(dept_ID)
); 

ALTER TABLE Instructor
ALTER inst_ID SET DEFAULT('XXX00');

-- Validations - Instructor Table 

-- Contact number validation

ALTER TABLE Instructor 
ADD CONSTRAINT `instContactVal`
CHECK (inst_contactNo REGEXP '^[1-9][0-9]{9}$'); 

-- Email number validation 

ALTER TABLE Instructor 
ADD CONSTRAINT `instEmailVal`
CHECK (inst_emailID REGEXP '@ahduni.edu.in$');

-- Gender validation

ALTER TABLE Instructor
ADD CONSTRAINT `instGenderVal`
CHECK (inst_gender = 'm' OR inst_gender = 'M' OR inst_gender = 'f' OR inst_gender = 'F');

-- Pincode validation 

ALTER TABLE Instructor
ADD CONSTRAINT `instPincodeVal`
CHECK (inst_pinCode REGEXP '[0-9]{6}');

DESC Instructor;

-- Course Table 

CREATE TABLE Course (
	course_ID varchar(6),
    course_name varchar(50) NOT NULL,
    course_dept int NOT NULL, 
    PRIMARY KEY(course_ID),
    FOREIGN KEY(course_dept) REFERENCES Department(dept_ID)
);

ALTER TABLE Course
ALTER course_ID SET DEFAULT('XXX000');

DESC Course;

-- Course/Facuty Table 

CREATE TABLE Course_Faculty (
	course_ID varchar(6) NOT NULL,
    faculty_ID varchar(5) NOT NULL,
    FOREIGN KEY(course_ID) REFERENCES Course(course_ID),
    FOREIGN KEY(faculty_ID) REFERENCES Instructor(inst_ID),
    PRIMARY KEY(course_ID, faculty_ID)
);

DESC Course_Faculty;

-- Sessions Table 

CREATE TABLE Sessions (
	course_ID varchar(6) NOT NULL,
    session_ID int NOT NULL,
    faculty_ID varchar(5) NOT NULL,
    session_date date NOT NULL,
    session_time datetime NOT NULL,
    FOREIGN KEY(course_ID, faculty_ID) REFERENCES Course_Faculty(course_ID, faculty_ID),
    PRIMARY KEY(course_ID, session_ID, session_date, faculty_ID)
);

ALTER TABLE Sessions
ALTER session_date SET DEFAULT(CURRENT_DATE);

DESC Sessions;

-- Components Table 

CREATE TABLE Components (
	course_ID varchar(6),
    comp_Name varchar(50) NOT NULL,
    comp_per int NOT NULL,
    FOREIGN KEY(course_ID) REFERENCES Course(course_ID),
    PRIMARY KEY(course_ID, comp_Name, comp_per)
);

ALTER TABLE Components 
ALTER comp_per SET DEFAULT(0);

DESC Components;

-- Validations - Components Table 

-- Component Percantage Validation 

ALTER TABLE Components 
ADD CONSTRAINT comPerVal
CHECK (comp_per >= 0 AND comp_PER <= 100);

-- Enrollment Table 

CREATE TABLE Enrollment (
	course_ID varchar(6) NOT NULL,
    std_ID varchar(20) NOT NULL,
    enrol_date date NOT NULL,
    enrol_time datetime NOT NULL,
    FOREIGN KEY(course_ID) REFERENCES Course(course_ID),
    FOREIGN KEY(std_ID) REFERENCES Student(std_ID),
    PRIMARY KEY(course_ID, std_ID)
);

ALTER TABLE Enrollment 
ALTER enrol_date SET DEFAULT(CURRENT_DATE);

ALTER TABLE Enrollment 
ALTER enrol_time SET DEFAULT(CURRENT_TIME);

DESC Enrollment;

-- Attendence Table 

CREATE TABLE Attendance (
	course_ID varchar(6) NOT NULL,
    session_ID int NOT NULL,
    session_date date NOT NULL,
    faculty_ID varchar(5) NOT NULL,
    student_ID varchar(20) NOT NULL,
    present boolean NOT NULL,
    FOREIGN KEY(course_ID, session_ID, session_date, faculty_ID) REFERENCES Sessions(course_ID, session_ID, session_date, faculty_ID),
    FOREIGN KEY(course_ID, student_ID) REFERENCES Enrollment(course_ID, std_ID),
    PRIMARY KEY(course_ID, session_ID, faculty_ID, student_ID)
);

DESC Attendance;

-- Assessment Table 

CREATE TABLE Assessment (
	course_ID varchar(6) NOT NULL,
    comp_Name varchar(50) NOT NULL,
    comp_per int NOT NULL,
    std_ID varchar(20) NOT NULL,
    total_Marks int NOT NULL,
    got_Marks int NOT NULL,
    final_Marks int NOT NULL,
    FOREIGN KEY(course_ID, comp_Name, comp_per) REFERENCES Components(course_ID, comp_Name, comp_per),
    FOREIGN KEY(course_ID, std_ID) REFERENCES Enrollment(course_ID, std_ID),
    PRIMARY KEY(course_ID, comp_Name, std_ID)
);

-- Validations - Assessment Table 

-- Marks validation 

ALTER TABLE Assessment
ADD CONSTRAINT marksVal 
CHECK (got_Marks >= 0 AND total_Marks >= 0 AND got_Marks <= total_Marks);

DESC Assessment;