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

