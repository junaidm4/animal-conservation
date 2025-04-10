CREATE TABLE student_details (
	student_id INT AUTO_INCREMENT PRIMARY KEY, 
    student_forename VARCHAR(30) NOT NULL, 
    student_surname VARCHAR(30) NOT NULL, 
	student_hashed_password VARCHAR(50) NOT NULL, 
    student_dob DATE NOT NULL, 
    access_code MEDIUMINT NOT NULL UNIQUE, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    enrolled_date DATE NOT NULL, 
    disability VARCHAR(100) 
);
SELECT * FROM student_details;

CREATE TABLE teacher_details (
	teacher_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY, 
    teacher_forename VARCHAR(30) NOT NULL, 
    teacher_surname VARCHAR(30) NOT NULL, 
	teacher_hashed_password VARCHAR(50) NOT NULL, 
    teacher_dob DATE NOT NULL, 
    teacher_email VARCHAR(255) NOT NULL UNIQUE, 
    teacher_hired_date DATE NOT NULL
);
SELECT * FROM teacher_details;

CREATE TABLE class_management (
	class_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY, 
    class_schedule DATETIME NOT NULL, 
    learning_content VARCHAR(1000) NOT NULL, 
	average_grade DECIMAL(5,2) DEFAULT 0.00
);
SELECT * FROM class_management;

CREATE TABLE assignment (
	assignment_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	assignment_name VARCHAR(20) NOT NULL,
    teacher_id MEDIUMINT NOT NULL,
    submitted_date DATETIME NOT NULL,
    FOREIGN KEY(teacher_id) REFERENCES teacher_details(teacher_id)
);
SELECT * FROM assignment;

CREATE TABLE assignment_students (
	assignment_id BIGINT, 
	student_id INT,
    grade DECIMAL(5,2) DEFAULT 0.00, 
    feedback TEXT NOT NULL,
    PRIMARY KEY (assignment_id, student_id),
    FOREIGN KEY(assignment_id) REFERENCES assignment(assignment_id),
    FOREIGN KEY(student_id) REFERENCES student_details(student_id)
);
SELECT * FROM assignment_students;

CREATE TABLE customisation (
	student_id INT PRIMARY KEY, 
    profile_pic BLOB, 
    profile_background_image MEDIUMBLOB, 
	profile_bio VARCHAR(625), 
	FOREIGN KEY(student_id) REFERENCES student_details(student_id)
);
SELECT * FROM customisation;

CREATE TABLE students_class_teachers (
	student_id INT, 
	class_id MEDIUMINT,
    teacher_id MEDIUMINT,
    PRIMARY KEY(student_id, class_id, teacher_id),
    FOREIGN KEY(student_id) REFERENCES student_details(student_id),
    FOREIGN KEY(class_id) REFERENCES class_management(class_id),
    FOREIGN KEY(teacher_id) REFERENCES teacher_details(teacher_id)
);
SELECT * FROM students_class_teachers;

CREATE TABLE notes (
	notes_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	student_id INT NOT NULL, 
    teacher_id MEDIUMINT NOT NULL,
    notes_content TEXT NOT NULL, 
    notes_timestamp TIME NOT NULL,
    FOREIGN KEY(student_id) REFERENCES student_details(student_id),
    FOREIGN KEY(teacher_id) REFERENCES teacher_details(teacher_id)
);
SELECT * FROM notes;

