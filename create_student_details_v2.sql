CREATE TABLE students (
	user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    access_code MEDIUMINT NOT NULL UNIQUE, 
    enrolled_date DATE NOT NULL, 
    disability VARCHAR(100),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM students;
