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


