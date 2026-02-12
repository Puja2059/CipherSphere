CREATE DATABASE ciphersphere;

USE ciphersphere;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    master_password VARCHAR(255) NOT NULL
);

-- Vault table
CREATE TABLE vault (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    platform VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Passwords table (for storing generated passwords)
CREATE TABLE passwords (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    platform VARCHAR(255),
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);