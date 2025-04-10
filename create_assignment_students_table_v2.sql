CREATE TABLE assignment_students (
	assignment_id BIGINT,
	user_id BIGINT,
    grade DECIMAL(5,2) DEFAULT 0.00, 
    feedback TEXT NOT NULL,
    PRIMARY KEY (assignment_id, user_id),
    FOREIGN KEY(assignment_id) REFERENCES assignment(assignment_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM assignment_students;
