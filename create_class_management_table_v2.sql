CREATE TABLE classes (
	class_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
    class_schedule DATETIME NOT NULL, 
    learning_content VARCHAR(1000) NOT NULL, 
	average_grade DECIMAL(5,2) DEFAULT 0.00,
    student_count TINYINT NOT NULL
);
SELECT * FROM classes;
