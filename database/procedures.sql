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
