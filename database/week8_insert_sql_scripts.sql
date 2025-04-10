-- SAME CODE
INSERT INTO organisations
VALUES (1, 'Coventry' , 'School', '2010-03-06', 'Active', '2015-03-06');
SELECT * FROM organisations;

INSERT INTO users
VALUES (1, 'Matthew' , 'Fisher' , 1, 'Student', 'abc123', '2010-03-06', 'MatthewFisher@coventry.ac.uk', '', '', ''),
(2, 'Christopher', 'Taylor', 1, 'Teacher', '987zyx', '1970-04-10', 'ChristopherTaylor@coventry.ac.uk', '', '', '');
SELECT * FROM users;

INSERT INTO students
VALUES (1, 789021, '2020-09-01', '');
SELECT * FROM students;

INSERT INTO message
VALUES (1, 1, 2, "I don't understand this task", 2022-05-17, 'Email');
SELECT * FROM message;

INSERT INTO classes
VALUES (1, '2021-09-20', 'Lesson 1 - What is a komodo dragon?', 72.89, 30);
SELECT * FROM classes;

INSERT INTO assignment
VALUES (1, 'Komodo article', 2, '2021-10-01');
SELECT * FROM assignment;

INSERT INTO assignment_students
VALUES (1, 1, 64.30, 'Write more words');
SELECT * FROM assignment_students;

INSERT INTO users_class_schools
VALUES (1, 1, 1);
SELECT * FROM users_class_schools;

-- NEW CODE
INSERT INTO services
VALUES (1, 'Games'),
(2, 'Videos'),
(3, 'Articles'),
(4, 'Canvas');
SELECT * FROM services;

INSERT INTO user_analytics
VALUES (1, 14, 'Male', 'United kingdom', '2023-05-27', 2, 4, 7, 'N/A', 'N/A');
SELECT * FROM user_analytics;

INSERT INTO digital_library
VALUES (1, 1, 1, '2021-07-20', 'An article on Komodos', 'https://komodo_article.co.uk', 'N/A', 7354763);
SELECT * FROM digital_library;

INSERT INTO student_assessment_logs
VALUES (1, 1, 'Started', 1, '2021-09-10', '192.168.1.10', 'iPhone', 'Incorrect');
SELECT * FROM student_assessment_logs;

INSERT INTO user_accounts_logs
VALUES (1, 1, 'Logout', '2021-09-10', '192.168.1.10', 'iPhone', 'Failure', 'Wrong password');
SELECT * FROM user_accounts_logs;

INSERT INTO user_activity_logs
VALUES (1, 1, 'Started', 1, '2021-09-10', '192.168.1.10', 'iPhone');
SELECT * FROM user_activity_logs;

INSERT INTO customisation_logs
VALUES (1, 1, 'Customise', 'Profile pic', '2021-09-10', '192.168.1.10', 'iPhone');
SELECT * FROM customisation_logs;

INSERT INTO teacher_assessment_logs
VALUES (1, 2, 'Create', 'Assignment name', 1, '2021-09-10', '192.168.1.20', 'MacBook');
SELECT * FROM teacher_assessment_logs;

INSERT INTO teacher_feedback_logs
VALUES (1, 2, 1, 1, 'Add', 'Grade', '2021-09-10', '192.168.1.20', 'MacBook');
SELECT * FROM teacher_feedback_logs;

INSERT user_digital_library_logs
VALUES (1, 1, 'Uploaded', 1, '2021-09-10', '192.168.1.10', 'iPhone', 'Success', 'N/A');
SELECT * FROM user_digital_library_logs;

INSERT INTO class_logs
VALUES (1, 2, 'Add', 'Class schedule', 1, '2021-09-10', '192.168.1.20', 'MacBook', 'Failure', 'Permission denied');
SELECT * FROM class_logs;







