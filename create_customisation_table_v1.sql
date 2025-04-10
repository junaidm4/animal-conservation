CREATE TABLE customisation (
	student_id INT PRIMARY KEY, 
    profile_pic BLOB, 
    profile_background_image MEDIUMBLOB, 
	profile_bio VARCHAR(625), 
	FOREIGN KEY(student_id) REFERENCES student_details(student_id)
);
SELECT * FROM customisation;