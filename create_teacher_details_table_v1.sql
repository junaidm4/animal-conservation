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