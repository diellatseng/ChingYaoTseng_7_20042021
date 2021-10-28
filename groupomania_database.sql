DROP DATABASE IF EXISTS groupmania_database;

CREATE DATABASE groupmania_database;
USE groupmania_database;

CREATE TABLE `User` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
    img_url VARCHAR(255)
);

CREATE TABLE `Post` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    author_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    likes_count INT,
    comments_count INT,
    img_url INT,
    FOREIGN KEY (author_id) REFERENCES Users(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Comment` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    author_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE
);

CREATE TABLE `Like`(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_id INT NOT NULL,
    target_id INT NOT NULL,
    FOREIGN KEY(author_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(target_id) REFERENCES Posts(id) ON DELETE CASCADE
);

ALTER TABLE
    `Post` ADD INDEX posts_author_id_index(author_id);
ALTER TABLE
    `Comment` ADD INDEX comments_author_id_index(author_id);
ALTER TABLE
    `Comment` ADD INDEX comments_post_id_index(post_id);
ALTER TABLE
    `Like` ADD INDEX likes_author_id_index(author_id);
ALTER TABLE
    `Like` ADD INDEX likes_target_id_index(target_id);
    