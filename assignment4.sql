/*******************************
		PROG8080 Assignment 4
	Submitted by: Lucas Currah
	Student No: 7674542
	Date: 16 October, 2016
********************************/
USE SIS
-------------- Question 1 -------------------------
PRINT ''
PRINT 'Question 1'

DELETE FROM Person WHERE lastName = 'TANEJA' and firstName = 'INDU'
DELETE FROM Course WHERE number IN ('BUS1070', 'LIBS1010')

-------------- Question 2 -------------------------
PRINT ''
PRINT 'Question 2'

SELECT (SELECT number FROM Course
			WHERE number = pc.courseNumber) as [Course Number],
	   (SELECT hours FROM Course
			WHERE number = pc.courseNumber) as [Hours],
	   (SELECT credits FROM Course
			WHERE number = pc.courseNumber) as [Credits],
	   (SELECT name FROM Course
			WHERE number = pc.courseNumber) as [Name]
		FROM ProgramCourse pc, Program p
			WHERE pc.programCode = p.code AND p.acronym = 'ITID'

-------------- Question 3 -------------------------
PRINT ''
PRINT 'Question 3'

SELECT p.number, p.firstName, p.lastName
	FROM Person p
	WHERE p.number IN (SELECT studentNumber 
						FROM Payment py, PaymentMethod pym
						WHERE py.paymentMethodId = pym.id 
						    AND (pym.explanation = 'Cash' OR pym.explanation = 'Certified Cheque')
							AND py.amount > 1000)
	ORDER BY p.lastName

-------------- Question 4 -------------------------
PRINT ''
PRINT 'Question 4'

SELECT CONCAT(p.firstName, ' ', p.lastName) as [Name]
	FROM Student s, Person p
	WHERE s.number IN (SELECT sp.studentNumber
					   FROM StudentProgram sp, Program p, Credential c
					   WHERE sp.programCode = p.code
					       AND p.credentialCode = c.code
						   AND c.code = 'OCGC'
						   AND sp.programStatusCode = 'A')
	    AND s.number = p.number
		AND s.isInternational = 1
		AND s.academicStatusCode = 'N'

-------------- Question 5 -------------------------
PRINT ''
PRINT 'Question 5'

INSERT INTO Person 
	(firstName, lastName, number, street, city, 
	countryCode, postalCode, mainPhone, alternatePhone, 
	collegeEmail, personalEmail, birthdate)
VALUES (
	'INDU',
	'TANEJA',
	'7424476', 
	'FLAT NO. 100 TRIVENI APARTMENTS PITAM PURA',
	'New Delhi',
	(SELECT code FROM Country WHERE name = 'India'),
	'110034',
	'0141-6610242',
	'94324060195',
	'iteneja@conestoga.on.ca',
	'iteneja@bsni.co.in',
	'1989-10-07'
)

SELECT * 
FROM Person
WHERE firstName = 'INDU' AND lastName = 'TANEJA'

-------------- Question 6 -------------------------
PRINT ''
PRINT 'Question 6'

INSERT INTO Student
	(number, localStreet, localCity, localPostalCode, 
	 localProvinceCode, localCountryCode, localPhone,
	 isInternational, academicStatusCode, financialStatusCode,
	 sequentialNumber, balance)
VALUES(
	(SELECT number FROM Person WHERE firstName = 'INDU' AND lastName = 'TANEJA'),
	'442 Gibson ST N',
	'Kitchener',
	'N2M 4T4',
	(SELECT code FROM Province WHERE name = 'ONTARIO'),
	(SELECT code FROM Country WHERE name = 'CANADA'),
	'(226)-147-2985',
	1,
	'N',
	'D',
	0,
	1130
)

SELECT s.number, s.isInternational, s.academicStatusCode, 
	s.financialStatusCode, s.sequentialNumber, s.balance
FROM Student s, Person p
WHERE s.number = p.number
	AND p.lastName = 'TANEJA' AND firstName = 'INDU'

-------------- Question 7 -------------------------
PRINT ''
PRINT 'Question 7'

INSERT INTO StudentProgram (studentNumber, programCode, semester, programStatusCode)
VALUES(
	(SELECT number FROM Person WHERE firstName = 'INDU' AND lastName = 'TANEJA'),
	(SELECT code FROM Program WHERE acronym = 'CAD'),
	3,
	'A'
)

SELECT sp.studentNumber, sp.programCode, sp.semester, sp.programStatusCode
FROM StudentProgram sp, Person p
WHERE sp.studentNumber IN (SELECT number 
						   FROM Person 
						   WHERE firstName = 'INDU' AND p.lastName = 'TANEJA')

-------------- Question 8 -------------------------
PRINT ''
PRINT 'Question 8'

INSERT INTO CourseStudent (CourseOfferingId, studentNumber, finalMark)
VALUES (
	(SELECT id FROM CourseOffering WHERE sessionCode='F14' AND courseNumber = 'PROG8080'),
	(SELECT number FROM Person WHERE firstName = 'INDU' AND lastName = 'TANEJA'),
	0
)

SELECT cs.CourseOfferingId, cs.studentNumber, cs.finalMark
FROM CourseStudent cs
WHERE cs.studentNumber IN (SELECT number 
						  FROM Person
						  WHERE firstName = 'INDU' AND lastName = 'TANEJA') 

-------------- Question 9 -------------------------
PRINT ''
PRINT 'Question 9'

INSERT INTO Course (number, name, frenchName, hours, credits)
VALUES (
	'LIBS1010',
	'Critical Thinking Skills',
	'Pensee Critique',
	45,
	3
)

SELECT * FROM Course WHERE number = 'LIBS1010'

-------------- Question 10 -------------------------
PRINT ''
PRINT 'Question 10'

INSERT INTO Course 
VALUES(
	'BUS1070', 
	45, 
	3, 
	'Introduction to Human Relations', 
	'Introduction aux relations humaines'
)

SELECT * FROM Course WHERE number = 'BUS1070'

-------------- Question 11 -------------------------
PRINT ''
PRINT 'Question 11'

UPDATE IncidentalFee 
SET amountPerSemester = 100
WHERE item = 'Technology Enhancement Fee'

BEGIN TRANSACTION
	UPDATE IncidentalFee
	SET amountPerSemester = 150
	WHERE item = 'Technology Enhancement Fee'
ROLLBACK

SELECT amountPerSemester 
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee'

-------------- Question 12 -------------------------
PRINT ''
PRINT 'Question 12'

BEGIN TRANSACTION
	UPDATE IncidentalFee
	SET amountPerSemester = 200
	WHERE item = 'Technology Enhancement Fee'
COMMIT

SELECT amountPerSemester 
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee'



