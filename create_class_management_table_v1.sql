CREATE TABLE class_management (
	class_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY, 
    class_schedule DATETIME NOT NULL, 
    learning_content VARCHAR(1000) NOT NULL, 
	average_grade DECIMAL(5,2) DEFAULT 0.00
);
SELECT * FROM class_management;