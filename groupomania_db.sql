DROP DATABASE IF EXISTS `groupomania_db`;

CREATE DATABASE `groupomania_db`;
USE `groupomania_db`;

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `img_url` VARCHAR(255) DEFAULT 'http://localhost:3000/images/default.jpg',
	`role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER'
);

DROP TABLE IF EXISTS `Post`;
CREATE TABLE `Post` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content` TEXT NOT NULL,
    `author_id` INT NOT NULL,
    `created_at` TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
    `img_url` VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (author_id) REFERENCES `User`(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Comment`;
CREATE TABLE `Comment` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content` TEXT NOT NULL,
    `author_id` INT NOT NULL,
    `post_id` INT NOT NULL,
    `created_at` TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
    FOREIGN KEY (author_id) REFERENCES `User`(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES `Post`(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Like`;
CREATE TABLE `Like`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `author_id` INT NOT NULL,
    `target_id` INT NOT NULL,
    FOREIGN KEY(author_id) REFERENCES `User`(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(target_id) REFERENCES `Post`(id) ON DELETE CASCADE
);


# Create Admin user
INSERT 
	user (full_name, email, password, role) 
	VALUES ('Admin', 'admin@mail.com', '$2b$10$C4hG766j8.tQqDlpKDoZJ.mh5sIPjLxBxj8lnr7melk6kv3UmjJ2m', 'ADMIN');  
    
# Delete Admin user
DELETE
	FROM user
	WHERE id = 1;