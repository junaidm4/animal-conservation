-- WEEK 6
-- SAME CODE
CREATE TABLE organisations(
	organisation_id INT AUTO_INCREMENT PRIMARY KEY, 
    organisation_name VARCHAR(50) NOT NULL, 
    organisation_type ENUM('School', 'Community') NOT NULL, 
	enrolled_date DATE NOT NULL, 
    subscription_status ENUM('Active', 'Inactive', 'Pending', 'Expired') NOT NULL,
    expiry_date DATE NOT NULL
);
SELECT * FROM organisations;

CREATE TABLE users(
	user_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
    forename VARCHAR(30) NOT NULL, 
    surname VARCHAR(30) NOT NULL, 
    organisation_id INT NOT NULL,
    roles ENUM('Student', 'Teacher', 'Admin', 'Principal', 'Developer', 'Member') NOT NULL,
	hashed_password VARCHAR(50) NOT NULL, 
    dob DATE NOT NULL, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    profile_pic BLOB, 
    profile_background_image MEDIUMBLOB, 
    profile_bio VARCHAR(625),
    FOREIGN KEY(organisation_id) REFERENCES organisations(organisation_id)
);
SELECT * FROM users;

CREATE TABLE students (
	user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    access_code MEDIUMINT NOT NULL UNIQUE, 
    enrolled_date DATE NOT NULL, 
    disability VARCHAR(100),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM students;

CREATE TABLE message (
	message_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	sender_id BIGINT NOT NULL, 
    recipient_id BIGINT NOT NULL,
    message_content TEXT NOT NULL, 
    message_timestamp TIME NOT NULL,
    message_type ENUM('DM', 'Email', 'Notes') NOT NULL,
    FOREIGN KEY(sender_id) REFERENCES users(user_id),
    FOREIGN KEY(recipient_id) REFERENCES users(user_id)
);
SELECT * FROM message;

CREATE TABLE classes (
	class_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
    class_schedule DATETIME NOT NULL, 
    learning_content VARCHAR(1000) NOT NULL, 
	average_grade DECIMAL(5,2) DEFAULT 0.00,
    student_count TINYINT NOT NULL
);
SELECT * FROM classes;

CREATE TABLE assignment (
	assignment_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	assignment_name VARCHAR(20) NOT NULL,
    user_id BIGINT NOT NULL,
    submitted_date DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM assignment;

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

CREATE TABLE users_class_schools (
	user_id BIGINT, 
	class_id BIGINT,
    organisation_id INT,
    PRIMARY KEY(user_id, class_id, organisation_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(class_id) REFERENCES classes(class_id),
    FOREIGN KEY(organisation_id) REFERENCES organisations(organisation_id)
);
SELECT * FROM users_class_schools;

-- NEW CODE
CREATE TABLE services(
	service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(30)
);
SELECT * FROM services;

CREATE TABLE user_analytics(
	user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	age	TINYINT UNSIGNED NOT NULL,
	gender ENUM('Male', 'Female', 'Other')	NOT NULL,
	country	VARCHAR(60) NOT NULL,
	last_active	DATETIME NOT NULL,
	most_popular_service BIGINT NOT NULL,	
	least_popular_service BIGINT NOT NULL,
	feedback_score	SMALLINT NOT NULL,	
	feedback_praise	TEXT NOT NULL,	
	feedback_criticism	TEXT NOT NULL,	
	CHECK (feedback_score > 0 AND feedback_score <=10),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(most_popular_service) REFERENCES services(service_id),
    FOREIGN KEY(least_popular_service) REFERENCES services(service_id)
    
);
SELECT * FROM user_analytics;

CREATE TABLE digital_library (
	digital_library_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
	user_id BIGINT NOT NULL, 
    organisation_id INT NOT NULL,
    uploaded_date DATETIME NOT NULL, 
    file_name VARCHAR(100) NOT NULL,
    file_link TEXT NOT NULL,
    file_info TEXT NOT NULL,
    views BIGINT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(organisation_id) REFERENCES organisations(organisation_id)
);
SELECT * FROM digital_library;

CREATE TABLE student_assessment_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Clicked', 'Started', 'Paused', 'Finished', 'Submitted') NOT NULL,
    assignment_id BIGINT NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
	answers ENUM ('Correct', 'Incorrect', 'N/A') NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(assignment_id) REFERENCES assignment(assignment_id)
);
SELECT * FROM student_assessment_logs;

CREATE TABLE user_accounts_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Login', 'Logout', 'Other') NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
	action_status ENUM ('Success', 'Failure') NOT NULL,
	failure_reason ENUM ('Wrong password', 'Locked account', 'Wrong access code', 'Maintenance', 'N/A') NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM user_accounts_logs;

CREATE TABLE user_activity_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Clicked', 'Started', 'Paused', 'Finished') NOT NULL,
    service_id BIGINT NOT NULL, 
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(service_id) REFERENCES services(service_id)
);
SELECT * FROM user_activity_logs;

CREATE TABLE customisation_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Customise', 'Remove') NOT NULL,
	customise_which ENUM ('Profile Pic', 'Bio', 'Background image') NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM customisation_logs;

CREATE TABLE teacher_assessment_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Create', 'Edit', 'Set', 'Remove') NOT NULL,
	assignment_parts ENUM ('Assignment name', 'Asssignment details', 'Questions', 'Deadline') NOT NULL,
    assignment_id BIGINT NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(assignment_id) REFERENCES assignment(assignment_id)
);
SELECT * FROM teacher_assessment_logs;

CREATE TABLE teacher_feedback_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	teacher_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    assignment_id BIGINT NOT NULL,
	action_type ENUM ('Add', 'Edit', 'Remove') NOT NULL,
	results ENUM ('Grade', 'Feedback') NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
    FOREIGN KEY(teacher_id) REFERENCES users(user_id),
    FOREIGN KEY(student_id) REFERENCES users(user_id),
    FOREIGN KEY(assignment_id) REFERENCES assignment_students(assignment_id)
);
SELECT * FROM teacher_feedback_logs;

CREATE TABLE user_digital_library_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Uploaded', 'Downloaded', 'Edited', 'Viewed', 'Removed') NOT NULL,
    content_id BIGINT NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
	action_status ENUM ('Success', 'Failure') NOT NULL,
	failure_reason ENUM ('Permission denied', 'N/A') NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
SELECT * FROM user_digital_library_logs;

CREATE TABLE class_logs(
	log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT NOT NULL,
	action_type ENUM ('Add', 'Edit', 'Remove') NOT NULL,
	class_info ENUM ('Class schedule', 'Learning content') NOT NULL,
    class_id BIGINT NOT NULL,
	timestamp DATETIME NOT NULL, 
	ip_address VARCHAR(60) NOT NULL,
	device_info TEXT NOT NULL,
	action_status ENUM ('Success', 'Failure') NOT NULL,
	failure_reason ENUM ('Permission denied', 'N/A') NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(class_id) REFERENCES classes(class_id)
);
SELECT * FROM class_logs;

