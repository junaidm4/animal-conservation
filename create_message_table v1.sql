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
