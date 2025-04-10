CREATE TABLE assignment (
	assignment_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	assignment_name VARCHAR(20) NOT NULL,
    teacher_id MEDIUMINT NOT NULL,
    submitted_date DATETIME NOT NULL,
    FOREIGN KEY(teacher_id) REFERENCES teacher_details(teacher_id)
);
SELECT * FROM assignment;

