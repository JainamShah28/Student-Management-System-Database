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