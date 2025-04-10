CREATE TABLE assignment (
	assignment_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	assignment_name VARCHAR(20) NOT NULL,
    user_id BIGINT NOT NULL,
    submitted_date DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM assignment;
