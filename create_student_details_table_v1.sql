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