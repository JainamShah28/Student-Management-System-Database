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

USE Student_Management_System;

-- Department Table 

INSERT INTO Department(dept_Name) VALUES('Computer Science And Engineering');

INSERT INTO Department(dept_Name) VALUES('Chemical Engineering');

INSERT INTO Department(dept_Name) VALUES('Mechenical Engineering');

SELECT * FROM Department;

-- Student Table 

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Jainam', 'Nitesh', 'Shah', 1, '9825305409', '2003-03-28', 'jainam.s5@ahduni.edu.in', 'M', '303. Kamdhenu Appartment', 'Sudama Street, Vikasgruh Road', 'Jamnagar', 'Gujarat', '361008', 'Nitesh Shah', 'Shilpa Shah');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Devansh', 'Vipul', 'Purani', 1, '8000119988', '2003-03-28', 'devansh.p@ahduni.edu.in', 'M', 'B12/A, Devdarshan Tower', 'Satelite Area', 'Ahmedabad', 'Gujarat', '380015', 'Vipul Purani', 'Preeti Purani');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Aryan', 'Bhavin', 'Bhavsar', 1, '7623909369', '2003-08-18', 'aryan.b@ahduni.edu.in', 'M', 'B/21, Chitrakut Bungalows', 'Opp. Sai Mandir, Malpur Road', 'Modasa', 'Gujarat', '380015', 'BhavinKumar Bhavsar', 'Manisha Bhavsar');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Daksh', 'Vijaykumar', 'Suthar', 2, '9016464730', '2003-06-22', 'daksh.s@ahduni.edu.in', 'M', '46, Somnathpark society', 'Sargasan', 'Gandhinagar', 'Gujarat', '382421', 'Vijaykumar Suthar', 'Harshaben Suthar');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Archana', 'Amrit', 'Khurana', 2, '9512924138', '2002-05-07', 'archana.k@ahduni.edu.in', 'F', '12, Unnati Society', 'Ajwa Road', 'Vadodra', 'Gujarat', '390019', 'Amrit Khurana', 'Priya Khurana');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Samarth', 'Vipul', 'Chaudhari', 3, '9525024165', '2001-03-18', 'samarth.c@ahduni.edu.in', 'M', '204, Vision Complex', 'Panjarapole Cross Road', 'Ahmedabad', 'Gujarat', '380015', 'Vipul Chaudhari', 'Radha Chaudhari');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Dev', 'Pranay', 'Dave', 3, '6521274198', '2001-07-01', 'dev.d@ahduni.edu.in', 'M', '129/a, Nutan Saurabh Society', 'Harni Road', 'Vadodra', 'Gujarat', '390006', 'Pranay Dave', 'Nilanjna Dave');

INSERT INTO Student(std_fName, std_midName, std_lName, std_dept, std_contactNo, std_birthDate, std_emailID, std_gender, std_houseName, std_streetName, std_city, std_state, std_pincode, std_fatherName, std_motherName)
VALUES('Ankit', 'Bharat', 'Sha', 1, '8910472907', '1960-05-13', 'ankit.s@ahduni.edu.in', 'M', '3rd, Samarpan Complex', 'Navrangpura', 'Ahmedabad', 'Gujarat', '380009', 'Bharat Sha', 'Brinda Sha');

SELECT std_ID, CONCAT(std_fName, ' ', std_lName) AS std_Name, std_dept, std_contactNo, std_birthDate, std_age, std_emailID, std_gender
FROM Student;

SELECT CONCAT(std_houseName, ',', std_streetName, ',', std_state, ',', std_city, '-', std_pinCode) AS Address, std_fatherName, std_motherName
FROM Student;

-- Instructor Table

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Akhand', 'Sunil', 'Rai', 2, '6618486177', '1975-01-01', 'akhan.rai@ahduni.edu.in', 'M', 'P/408', 'Green Street', 'Noida', 'Uttar Pradesh', '110096');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Ramesh', 'Jignesh', 'Vaghani', 2, '9216873414', '1980-05-04', 'ramesh.v@ahduni.edu.in', 'M', 'C/2', 'Swastik Road', 'Ahmedabad', 'Gujarat', '382440');

SELECT * FROM Instructor;

-- Instructor Table

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Akhand', 'Sunil', 'Rai', 2, '6618486177', '1975-01-01', 'akhan.rai@ahduni.edu.in', 'M', 'P/408', 'Green Street', 'Noida', 'Uttar Pradesh', '110096');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Ramesh', 'Jignesh', 'Vaghani', 2, '9216873414', '1980-05-04', 'ramesh.v@ahduni.edu.in', 'M', 'C/2', 'Swastik Road', 'Ahmedabad', 'Gujarat', '382440');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Dhaval', 'Mukund', 'Patel', 1, '9761614564', '1981-02-25', 'dhaval.p@ahduni.edu.in', 'M', 'B/45', 'Vatva', 'Ahmedabad', 'Gujarat', '382440');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Suresh', 'Jigar', 'Parikh', 1, '9988439712', '1985-02-07', 'suresh.p@ahduni.edu.in', 'M', 'B/101', 'Ambawadi', 'Ahmedabad', 'Gujarat', '380015');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Sakshi', 'Manohar', 'Soni', 3, '7464156735', '1990-09-09', 'sakshi.s@ahduni.edu.in', 'F', 'D/103', 'Naranpura', 'Ahmedabad', 'Gujarat', '380139');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Ratna', 'Nishit', 'Desai', 3, '9313872688', '1983-06-19', 'ratna.d@ahduni.edu.in', 'F', 'A/21', 'Shyamal', 'Ahmedabad', 'Gujarat', '380015');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Minal', 'Viren', 'Sheth', 1, '8952433215', '1988-11-23', 'minal.s@ahduni.edu.in', 'F', 'J/35', 'Malpur Road', 'Modasa', 'Gujarat', '383315');

INSERT INTO Instructor(inst_fName, inst_midName, inst_lName, inst_dept, inst_contactNo, inst_birthDate, inst_emailID, inst_gender, inst_houseName, inst_streetName, inst_city, inst_state, inst_pincode)
VALUES('Grishma', 'Manoj', 'Trivedi', 2, '9392322688', '1987-10-17', 'grishma.t@ahduni.edu.in', 'F', 'D/3', 'Juhapura', 'Ahmedabad', 'Gujarat', '380321');

SELECT * FROM instructor;

-- Course Table 

INSERT INTO Course(course_name, course_dept)
VALUES('Database Management Systems', 1);

INSERT INTO Course(course_name, course_dept)
VALUES('Data Structures and Algorithms', 1);

INSERT INTO Course(course_name, course_dept)
VALUES('Design and Analysis of Algorithms', 1);

INSERT INTO Course(course_name, course_dept)
VALUES('Surface Chemistry', 2);

INSERT INTO Course(course_name, course_dept)
VALUES('Chemical Reactions', 2);

INSERT INTO Course(course_name, course_dept)
VALUES('Organic Compounds', 2);

INSERT INTO Course(course_name, course_dept)
VALUES('Rigid Body Dynamics', 3);

INSERT INTO Course(course_name, course_dept)
VALUES('Thermodynamics', 3);

INSERT INTO Course(course_name, course_dept)
VALUES('Modern Physics', 3);

SELECT * FROM Course;

-- Course / Faculty Table 

INSERT INTO Course_Faculty
VALUES('CSE001', 'CSE03');

INSERT INTO Course_Faculty
VALUES('CSE002', 'CSE02');

INSERT INTO Course_Faculty
VALUES('MEC001', 'MEC02');

INSERT INTO Course_Faculty
VALUES('MEC002', 'MEC01');

INSERT INTO Course_Faculty
VALUES('CHE003', 'CHE02');

INSERT INTO Course_Faculty
VALUES('CSE002', 'CSE01');

INSERT INTO Course_Faculty
VALUES('CHE001', 'CHE01');

INSERT INTO Course_Faculty 
VALUES('CHE002', 'CHE03');

INSERT INTO Course_Faculty
VALUES('CSE003', 'CSE01');

INSERT INTO Course_Faculty
VALUES('MEC003', 'MEC01');

INSERT INTO Course_Faculty
VALUES('MEC003', 'MEC02');

SELECT * FROM Course_Faculty;

-- Sessions table 

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-01', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-03', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-05', STR_TO_DATE('17:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-08', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-10', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-12', STR_TO_DATE('17:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-15', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-17', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-19', STR_TO_DATE('17:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-22', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-24', '13:00:00');

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE001', 'CSE03', '2021-12-26', STR_TO_DATE('17:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-03', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-04', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-09', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-10', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-15', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-16', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-21', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-22', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-27', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2021-12-28', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2022-01-02', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE002', 'CSE01', '2022-01-03', STR_TO_DATE('14:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-01-04', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-01-11', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-01-18', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-01-25', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-02-02', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-02-09', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('CSE003', 'CSE01', '2022-02-16', STR_TO_DATE('09:30:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('MEC001', 'MEC02', '2022-02-02', STR_TO_DATE('08:00:00', '%H:%i:%s'));

INSERT INTO Sessions(course_ID, faculty_ID, session_date, session_time)
VALUES('MEC001', 'MEC02', '2022-02-02', STR_TO_DATE('16:00:00', '%H:%i:%s'));

SELECT * FROM Sessions;

-- Components Table 

INSERT INTO Components
VALUES('CSE001', 'Quiz', 30);

INSERT INTO Components
VALUES('CSE001', 'Mid Semester Exam', 30);

INSERT INTO Components
VALUES('CSE001', 'Project', 10);

INSERT INTO Components
VALUES('CSE001', 'End Semester Exam', 30);

INSERT INTO Components 
VALUES('CSE002', 'Class Participation / Attendance', 10); 

INSERT INTO Components 
VALUES('CSE002', 'Viva', 20);

INSERT INTO Components 
VALUES('CSE002', 'Practical Exam', 20);

INSERT INTO Components
VALUES('CSE002', 'Project', 25);

INSERT INTO Components 
VALUES('CSE002', 'End Semester Exam', 25);

SELECT * FROM Components;

-- Enrollment Table 

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200001');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200002');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200003');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200004');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200005');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE001', 'AU2200006');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE002', 'AU2200001');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE002', 'AU2200002');

INSERT INTO Enrollment(course_ID, std_ID)
VALUES('CSE002', 'AU2200003');

SELECT * FROM Enrollment;

-- Attendance Table 

INSERT INTO Attendance 
VALUES('CSE002', 1, '2021-12-03', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 2, '2021-12-04', 'CSE01', 'AU2200001', 0);

INSERT INTO Attendance 
VALUES('CSE002', 3, '2021-12-09', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 4, '2021-12-10', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 5, '2021-12-15', 'CSE01', 'AU2200001', 0);

INSERT INTO Attendance 
VALUES('CSE002', 6, '2021-12-16', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 7, '2021-12-21', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 8, '2021-12-22', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 9, '2021-12-27', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 10, '2021-12-28', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 11, '2022-01-02', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE002', 12, '2022-01-03', 'CSE01', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 1, '2021-12-01', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 2, '2021-12-03', 'CSE03', 'AU2200001', 0);

INSERT INTO Attendance 
VALUES('CSE001', 3, '2021-12-05', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 4, '2021-12-08', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 5, '2021-12-10', 'CSE03', 'AU2200001', 0);

INSERT INTO Attendance 
VALUES('CSE001', 6, '2021-12-12', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 7, '2021-12-15', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 8, '2021-12-17', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 9, '2021-12-19', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 10, '2021-12-22', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 11, '2021-12-24', 'CSE03', 'AU2200001', 1);

INSERT INTO Attendance 
VALUES('CSE001', 12, '2021-12-26', 'CSE03', 'AU2200001', 1);

SELECT * FROM Attendance;

-- Assessment Table 

INSERT INTO Assessment(course_ID, comp_name, comp_per, std_ID, total_marks, got_marks)
VALUES('CSE001', 'End Semester Exam', 30, 'AU2200001', 50, 48);

INSERT INTO Assessment(course_ID, comp_name, comp_per, std_ID, total_marks, got_marks)
VALUES('CSE001', 'Mid Semester Exam', 30, 'AU2200001', 40, 35);

INSERT INTO Assessment(course_ID, comp_name, comp_per, std_ID, total_marks, got_marks)
VALUES('CSE001', 'Project', 10, 'AU2200001', 25, 21);

INSERT INTO Assessment(course_ID, comp_name, comp_per, std_ID, total_marks, got_marks)
VALUES('CSE001', 'Quiz', 30, 'AU2200001', 30, 21);

SELECT * FROM Assessment;

USE Student_Management_System;

-- 1. Procedure to display the details of all students of the given department

DROP PROCEDURE IF EXISTS `stdInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE stdInDept(deptID int)
BEGIN
	SELECT Student.std_ID, CONCAT(Student.std_fName, ' ', Student.std_lName) AS std_name 
    FROM Student
    INNER JOIN Department
    ON Student.std_dept = deptID AND Student.std_dept = Department.dept_ID;
END $$
DELIMITER ;

CALL stdInDept(1);

-- 2. Procedure to display total no of students in each department

DROP PROCEDURE IF EXISTS `noOfStdInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE noOfStdInDept()
BEGIN
	SELECT Department.dept_Name, COUNT(Student.std_ID) AS noOfStudents
    FROM Student 
    INNER JOIN Department
    ON Student.std_dept = Department.dept_ID
    GROUP BY Department.dept_Name;
END $$
DELIMITER ;

CALL noOfStdInDept();

-- 3. Procedure to display details of all instructors of given department

DROP PROCEDURE IF EXISTS `instInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE instInDept(deptId int)
BEGIN
	SELECT Instructor.inst_ID, CONCAT(Instructor.inst_fName, ' ', Instructor.inst_lName) AS inst_name 
    FROM Instructor
    INNER JOIN Department
    ON Instructor.inst_dept = deptID AND Instructor.inst_dept = Department.dept_ID;
END $$

CALL instInDept(1);

-- 4. Procedure to display total no of instructors in each department 

DROP PROCEDURE IF EXISTS `noOfInstInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE noOfInstInDept()
BEGIN
	SELECT Department.dept_Name, COUNT(Instructor.inst_ID) AS noOfInstructors
    FROM Instructor
    INNER JOIN Department
    ON Instructor.inst_dept = Department.dept_ID
    GROUP BY Department.dept_Name;
END $$

DELIMITER ;

CALL noOfInstInDept();

-- 5. Procedure to display all the courses of the given department 

DROP PROCEDURE IF EXISTS `courseInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE `courseInDept`(deptID int)
BEGIN
	SELECT course_ID, course_name
    FROM Course
    INNER JOIN Department
    ON Course.course_dept = deptID AND Course.course_dept = Department.dept_ID;
END $$
DELIMITER ;

CALL courseInDept(1);

-- 6. Procedure to display total no of courses in each department 

DROP PROCEDURE IF EXISTS `noOfCourseInDept`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE `noOfCourseInDept`()
BEGIN
	SELECT Department.dept_Name, COUNT(Course.course_ID) AS noOfCourses
    FROM Course
    INNER JOIN Department
    ON Course.course_dept = Department.dept_ID
    GROUP BY Department.dept_Name;
END $$
DELIMITER ;

CALL noOfCourseInDept();

-- 7. Procedure to display the details of all courses which are taught by the specified faculty

DROP PROCEDURE IF EXISTS `getCourses`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE getCourses(facID varchar(5)) 
BEGIN
	SELECT CONCAT(Course.course_ID, ' - ', Course.course_name) AS course
    FROM Course
    INNER JOIN Course_Faculty
    ON Course_Faculty.faculty_ID = facID AND Course.course_ID = Course_Faculty.course_ID;
END $$
DELIMITER ;

CALL getCourses('CSE01');

-- 8. Procedure to display the faculties of the specified course

DROP PROCEDURE IF EXISTS `getFaculties`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE getFaculties(courseID varchar(6))
BEGIN
	SELECT CONCAT(Instructor.inst_fName, ' ', Instructor.inst_lName) AS facName
    FROM Instructor
    INNER JOIN Course_Faculty
    ON Course_Faculty.course_ID = courseID AND Course_Faculty.faculty_ID = Instructor.inst_ID;
END $$
DELIMITER $$

CALL getFaculties('MEC003');

-- 9. Procedure to display all sessions of the given course 

DROP PROCEDURE IF EXISTS `sessionsOfCrse`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE sessionsOfCrse(courseID varchar(6))
BEGIN
	SELECT CONCAT('Session-', session_ID) AS sessionID, session_date, TIME(session_time) AS startTime FROM Sessions
    WHERE course_ID = courseID;
END $$
DELIMITER ;

CALL sessionsOfCrse('CSE003');

-- 10. Procedure to display the shedule of the faculty

DROP PROCEDURE IF EXISTS `displayFacultyShedule`;

DELIMITER $$
USE Student_Management_System $$
CREATE PROCEDURE displayFacultyShedule(facID varchar(5))
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE courseID varchar(6);
    DECLARE courseName varchar(100);
    DECLARE sessionDate date;
    DECLARE sessionTime datetime;
    DECLARE sessionDay int;
    DECLARE dayName varchar(20);
    
	DECLARE allSessions CURSOR FOR (
		SELECT Sessions.course_ID, Course.course_name, Sessions.session_date, TIME(Sessions.session_time) AS session_time, WEEKDAY(Sessions.session_date) AS session_day
		FROM Sessions
		INNER JOIN Course
		ON Sessions.faculty_ID = facID AND Sessions.course_ID = Course.course_ID
        GROUP BY Sessions.session_date
		ORDER BY Sessions.session_date, TIME(Sessions.session_time)
	);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    CREATE TEMPORARY TABLE facultyShedule (
		sessionDay varchar(200),
        course varchar(200),
        sessionTime varchar(100)
    );
    
    OPEN allSessions;
    read_cursor: LOOP
		FETCH allSessions INTO courseID, courseName, sessionDate, sessionTime, sessionDay;
        IF done THEN
			LEAVE read_cursor;
        END IF;
        
        CASE sessionDay
			WHEN 1 THEN
				SET dayName = 'Monday';
			WHEN 2 THEN 
				SET dayName = 'Tuesday';
            WHEN 3 THEN
				SET dayName = 'Wednesday';
            WHEN 4 THEN
				SET dayName = 'Thursday';
            WHEN 5 THEN
				SET dayName = 'Friday';
            WHEN 6 THEN
				SET dayName = 'Saturday';
            ELSE
				ITERATE read_cursor;
		END CASE;
        
        INSERT INTO facultyShedule
        VALUES(CONCAT(dayName ,' - ', sessionDate), CONCAT(courseID, ' - ', courseName), CONCAT(LEFT(TIME(sessionTime), 5), ' - ', LEFT(DATE_ADD(TIME(sessionTime), INTERVAL 90 MINUTE), 5)));
    END LOOP;
    
    SELECT * FROM facultyShedule;
END $$
DELIMITER ; 

CALL displayFacultyShedule('CSE01');

USE Student_Management_System;

-- 1. Function to count total number of departments 

DROP FUNCTION IF EXISTS `cntDepts`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntDepts() RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(dept_ID) AS UNSIGNED) FROM Department);
END $$
DELIMITER ;

SELECT CONCAT('No of departments: ', cntDepts());

-- 2. Function to count total number of students 

DROP FUNCTION IF EXISTS `cntStds`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntStds() RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(std_ID) AS UNSIGNED) FROM Student);
END $$
DELIMITER ;

SELECT CONCAT('No of students: ', cntStds());

-- 3. Function to count total number of instructors

DROP FUNCTION IF EXISTS `cntInst`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntInst() RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(inst_ID) AS UNSIGNED) FROM Instructor);
END $$
DELIMITER ;

SELECT CONCAT('No of Instructors: ', cntInst());

-- 4. Function to count total number of courses

DROP FUNCTION IF EXISTS `cntCourse`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntCourse() RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(course_ID) AS UNSIGNED) FROM Course);
END $$
DELIMITER ;

SELECT CONCAT('No of Courses: ', cntCourse());

-- 5. Function to count total sessions of the given course 

DROP FUNCTION IF EXISTS `cntSessions`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntSessions(courseID varchar(6)) RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(session_ID) AS UNSIGNED) FROM Sessions WHERE course_ID = courseID GROUP BY course_ID);
END $$
DELIMITER ;

SELECT CONCAT('No of sessions in course ', 'CSE0001-', (SELECT course_name FROM Course WHERE course_ID = 'CSE001'), ': ', cntSessions('CSE001'));

-- 6. Function to count total no of enrollemnts in the specified course 

DROP FUNCTION IF EXISTS `cntEnrollments`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntEnrollments(courseID varchar(6)) RETURNS int
READS SQL DATA 
DETERMINISTIC
BEGIN
	RETURN (SELECT CAST(COUNT(std_ID) AS UNSIGNED) FROM Enrollment WHERE course_ID = courseID GROUP BY course_ID);
END $$
DELIMITER ;

SELECT CONCAT('No of enrolments in course ', 'CSE0001-', (SELECT course_name FROM Course WHERE course_ID = 'CSE001'), ': ', cntEnrollments('CSE001'));

-- 7. Function to count total no of sessions attended by the student of the given course 


DROP FUNCTION IF EXISTS `cntAtdSesOfCourse`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntAtdSesOfCourse(stdID varchar(9), courseID varchar(6)) RETURNS int 
READS SQL DATA 
DETERMINISTIC
BEGIN
	RETURN (
		SELECT CAST(COUNT(session_ID) AS UNSIGNED) FROM Attendance 
		WHERE student_ID = stdID AND course_ID = courseID AND present = 1
    );
END $$
DELIMITER ;

SELECT CONCAT('No of sessions of course ', 'CSE001-', (SELECT course_name FROM Course WHERE course_ID = 'CSE001'), ' attended by ', (SELECT CONCAT(std_fName, ' ', std_lName) AS name FROM Student WHERE std_ID = 'AU2200001'), ' : ', cntAtdSesOfCourse('AU2200001', 'CSE001'));

-- 8. Function to calculate attendance of the specified student in specified subject

DROP FUNCTION IF EXISTS `cntAtdOfCourse`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntAtdOfCourse(stdID varchar(9), courseID varchar(6)) RETURNS int 
READS SQL DATA 
DETERMINISTIC
BEGIN
	DECLARE totalSessions int;
    DECLARE sessionsAttended int;
    
    SET totalSessions = cntSessions(courseID);
    SET sessionsAttended = cntAtdSesOfCourse(stdID, courseID);
    
    RETURN CEIL((sessionsAttended * 100) / totalSessions);
END $$
DELIMITER ;

SELECT CONCAT('Attendance of ', (SELECT CONCAT(std_fName, ' ', std_lName) FROM Student WHERE std_ID = 'AU2200001'), ' in CSE001-', (SELECT course_name FROM Course WHERE course_ID = 'CSE001'), ' is: ', cntAtdOfCourse('AU2200001', 'CSE001'), '%');

-- 9. Function to find overall how many sessions attended by the student 

DROP FUNCTION IF EXISTS `cntOverallAtdSesOfStd`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntOverallAtdSesOfStd(stdID varchar(9)) RETURNS int 
READS SQL DATA 
DETERMINISTIC
BEGIN
	RETURN (
		SELECT CAST(COUNT(session_ID) AS UNSIGNED) FROM Attendance 
		WHERE student_ID = stdID AND present = 1
    );
END $$
DELIMITER ;

SELECT CONCAT('No of sessions attended by ', (SELECT CONCAT(std_fName, ' ', std_lName) AS name FROM Student WHERE std_ID = 'AU2200001'), ' : ', cntOverallAtdSesOfStd('AU2200001'));

-- 10. Function to calculate overall attendance of the student 

DROP FUNCTION IF EXISTS `cntOverallAtdOfStd`;

DELIMITER $$
USE Student_Management_System $$
CREATE FUNCTION cntOverallAtdOfStd(stdID varchar(9)) RETURNS int 
READS SQL DATA 
DETERMINISTIC
BEGIN
	DECLARE totalSessions int;
    DECLARE sessionsAttended int;
    
    SET totalSessions = (SELECT CAST(COUNT(session_ID) AS UNSIGNED) FROM Attendance WHERE student_ID = stdID);
    SET sessionsAttended = cntOverallAtdSesOfStd(stdID);
    
    RETURN CEIL((sessionsAttended * 100) / totalSessions);
END $$
DELIMITER ;

SELECT CONCAT('Attendance of ', (SELECT CONCAT(std_fName, ' ', std_lName) FROM Student WHERE std_ID = 'AU2200001'), ' is: ', cntOverallAtdOfStd('AU2200001'), '%');

USE Student_Management_System;

-- 1. Trigger to generate unique student ID
 
DROP TRIGGER IF EXISTS `generateStdID`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER `generateStdID` BEFORE INSERT
ON Student FOR EACH ROW 
BEGIN
    DECLARE newID varchar(20);
    SET @newID = (SELECT CONCAT('AU', RIGHT(YEAR(CURRENT_DATE()), 2), RIGHT(CONCAT('00000', ((SELECT MAX(CAST(RIGHT(std_id, 5) AS UNSIGNED)) FROM Student) + 1)), 5)));
    
    SET NEW.std_ID = @newID;
END $$
DELIMITER ;

SELECT std_ID, CONCAT(std_fName, ' ', std_lName) AS std_name
FROM Student;

-- 2. Trigger to compute the age of the student 

DROP TRIGGER IF EXISTS `calcStdAge`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER `calcStdAge` BEFORE INSERT
ON Student FOR EACH ROW
BEGIN
    SET NEW.std_age = TIMESTAMPDIFF(YEAR, NEW.std_birthDate, CURRENT_DATE());
END $$
DELIMITER ;

SELECT std_ID, CONCAT(std_fName, ' ', std_lName) AS std_name, std_birthDate, std_age
FROM Student;

-- 3. Trigger to generate the Id of the instructor 

DROP TRIGGER IF EXISTS `generateInstID`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER `generateInstID` BEFORE INSERT
ON Instructor FOR EACH ROW 
BEGIN
    DECLARE newID varchar(20);
    DECLARE deptCode varchar(3);
    DECLARE dept int;
    DECLARE lastID int;
    
    SET dept = NEW.inst_dept;
    SET lastID = (SELECT MAX(CAST(RIGHT(inst_ID, 2) AS UNSIGNED)) FROM (SELECT inst_ID FROM Instructor WHERE inst_dept = NEW.inst_dept) AS allInst);
    
    IF lastID IS NULL THEN 
		SET lastID = 0;
	END IF;
    
    IF dept = 1 THEN
		SET deptCode = 'CSE';
    ELSEIF dept = 2 THEN
		SET deptCode = 'CHE';
    ELSEIF dept = 3 THEN
		SET deptCode = 'MEC';
    END IF;
    
	SET newID = CONCAT(deptCode, RIGHT(CONCAT('00', (lastID + 1)), 2));
    SET NEW.inst_ID = newID;
END $$
DELIMITER ;

SELECT inst_ID, CONCAT(inst_fName, ' ', inst_lName) AS name FROM Instructor;

-- 4. Trigger to compute the age of the faculty

DROP TRIGGER IF EXISTS `calcInstAge`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER `calcInstAge` BEFORE INSERT
ON Instructor FOR EACH ROW
BEGIN
    SET NEW.inst_age = TIMESTAMPDIFF(YEAR, NEW.inst_birthDate, CURRENT_DATE());
END $$
DELIMITER ;

SELECT inst_ID, CONCAT(inst_fName, ' ', inst_lName) AS inst_name, inst_birthDate, inst_age
FROM Instructor;

-- 5. Trigger to generate unique course ID

DROP TRIGGER IF EXISTS `generateCourseID`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER `generateCourseID` BEFORE INSERT
ON Course FOR EACH ROW
BEGIN
	DECLARE newID varchar(20);
    DECLARE deptCode varchar(3);
    DECLARE dept int;
    DECLARE lastID varchar(6);
    
    SET dept = NEW.course_dept;
    SET lastID = (SELECT MAX(RIGHT(course_ID, 3)) FROM (SELECT course_ID FROM Course WHERE course_dept = dept) AS allIDs);
    
    IF lastID IS NULL THEN
		SET lastID = 0;
	END IF;
    
    IF dept = 1 THEN
		SET deptCode = 'CSE';
    ELSEIF dept = 2 THEN
		SET deptCode = 'CHE';
    ELSEIF dept = 3 THEN
		SET deptCode = 'MEC';
    END IF;
    
	SET newID = CONCAT(deptCode, RIGHT(CONCAT('000', (lastID + 1)), 3));
    SET NEW.course_ID = newID;
END $$
DELIMITER ;

SELECT course_ID, course_name FROM Course;

-- 6. Trigger to check whether a faculty has been assigned more than two courses or not

DROP TRIGGER IF EXISTS `assignValidation`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER assignValidation BEFORE INSERT 
ON Course_Faculty FOR EACH ROW
BEGIN
	DECLARE count int;
    DECLARE msg varchar(300);
    
    SET count = (SELECT CAST(COUNT(course_ID) AS UNSIGNED) FROM Course_Faculty WHERE faculty_ID = NEW.faculty_ID GROUP BY faculty_ID);
    
    IF (count = 2) THEN
		SET msg = "Can't assign the faculty to this course as faculty is already assigned in the two courses";
		SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;
END $$
DELIMITER ;

INSERT INTO Course_Faculty
VALUES('MEC002', 'MEC02');

-- 7. Trigger to generate session ID for the course 

DROP TRIGGER IF EXISTS `generateSessionID`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER generateSessionID BEFORE INSERT
ON Sessions FOR EACH ROW 
BEGIN
	DECLARE lastID int;
    DECLARE newID int;
    
    SET lastID = (SELECT CAST(MAX(session_ID) AS UNSIGNED) FROM Sessions WHERE course_ID = NEW.course_ID);
    
    IF lastID IS NULL THEN
		SET lastID = 0;
	END IF;
    
    SET newID = lastID + 1;
    SET NEW.session_ID = newID;
END $$
DELIMITER ;

-- 8. Trigger to check whehter a faculty has another session at that time or not 

DROP TRIGGER IF EXISTS `isFacultyFree`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER isFacultyFree BEFORE INSERT
ON Sessions FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE sessionDate date;
    DECLARE sessionTime datetime;
    DECLARE msg varchar(300);
    
	DECLARE sessions CURSOR FOR (
		SELECT session_date, session_time FROM Sessions WHERE faculty_ID = NEW.faculty_ID
    );
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN sessions;
    read_cursor: LOOP
		FETCH sessions INTO sessionDate, sessionTime;
		IF done THEN 
			LEAVE read_cursor;
		END IF;
        IF (sessionDate = NEW.session_date) THEN
			IF (NEW.session_time BETWEEN sessionTime AND DATE_ADD(sessionTime, INTERVAL 90 MINUTE)) THEN
				SET msg = CONCAT("Can't able to plan the session on ", NEW.session_date, " at ", TIME(NEW.session_time), " as faculty has another session");
                SIGNAL SQLSTATE '45000' SET message_text = msg;
            END IF;
        END IF;
    END LOOP;
    CLOSE sessions;
END $$
DELIMITER ;

-- 8. Trigger to check whether the components of course are well set or not

DROP TRIGGER IF EXISTS `checkComp`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER checkComp BEFORE INSERT
ON Components FOR EACH ROW
BEGIN
	DECLARE compTotal int;
    DECLARE msg varchar(200);
    
    SET compTotal = (SELECT CAST(SUM(comp_per) AS UNSIGNED) FROM Components WHERE course_ID = NEW.course_ID GROUP BY course_ID);
    
    IF ((NEW.comp_per + compTotal) > 100) THEN
		SET msg = 'The total of all components for this course should be equal to 100';
		SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;
END $$
DELIMITER ;

-- 9. Trigger to calculate the final marks based on the evaluation percantage

DROP TRIGGER IF EXISTS `calcFinalMarks`;

DELIMITER $$
USE Student_Management_System $$
CREATE TRIGGER calcFinalMarks BEFORE INSERT
ON Assessment FOR EACH ROW
BEGIN
	SET NEW.final_marks = CEIL((NEW.comp_per * NEW.got_marks) / NEW.total_marks);
END $$
DELIMITER ;


