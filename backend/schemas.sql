show databases;
use railway;
show tables;
drop database railway;
show databases;
CREATE DATABASE ciphersphere;
use ciphersphere;
create table if not exists USERS(id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    login_hash VARBINARY(64) NOT NULL,
    salt VARBINARY(32) NOT NULL
);
create table if not exists vault (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    platform VARCHAR(100),
    username VARCHAR(100),
    encrypted_password BLOB,
    iv VARBINARY(16),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE passwords (
    id INT AUTO_INCREMENT PRIMARY KEY,
    site VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255)
);
