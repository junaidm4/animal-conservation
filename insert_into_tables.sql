INSERT INTO student_details
VALUES (1, 'Matthew' , 'Fisher', 'abc123', '2010-03-06', '789021', 'MatthewFisher@coventry.ac.uk', '2020-09-01', '');
SELECT * FROM student_details;

INSERT INTO teacher_details
VALUES (1, 'Christopher', 'Taylor', '987zyx', '1970-04-10', 'ChristopherTaylor@coventry.ac.uk', '2020-09-01');
SELECT * FROM teacher_details;

INSERT INTO class_management
VALUES (1, '2021-09-20', 'Lesson 1 - What is a komodo dragon?', 72.89);
SELECT * FROM class_management;

INSERT INTO assignment
VALUES (1, 'Komodo article', 1, '2021-10-01');
SELECT * FROM assignment;

INSERT INTO assignment_students
VALUES (1, 1, 64.30, 'Write more words');
SELECT * FROM assignment_students;

INSERT INTO students_class_teachers
VALUES (1, 1, 1);
SELECT * FROM students_class_teachers;

INSERT INTO customisation
VALUES (1, '', '', '');
SELECT * FROM customisation;

INSERT INTO notes
VALUES (1, 1, 1, "I don't understand this task", '10:30:28');
SELECT * FROM notes;
