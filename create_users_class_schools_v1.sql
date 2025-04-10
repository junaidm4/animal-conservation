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
