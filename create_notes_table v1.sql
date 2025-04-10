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