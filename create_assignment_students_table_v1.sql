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