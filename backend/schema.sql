-- Create database
CREATE DATABASE IF NOT EXISTS ciphersphere;
USE ciphersphere;

-- Users table: Stores user accounts with hashed passwords and encrypted vaults
-- Zero-knowledge: Login and master passwords are PBKDF2-hashed; vault is AES256-encrypted JSON blob
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,          -- Unique email for login
    password_hash VARCHAR(128) NOT NULL,         -- PBKDF2 hash of login password (never plaintext)
    master_password_hash VARCHAR(128),           -- PBKDF2 hash of master password (for vault access)
    salt VARCHAR(32) NOT NULL,                   -- Random salt for PBKDF2
    encrypted_vault TEXT                         -- AES256-encrypted JSON array of passwords (e.g., [{"platform": "google", "username": "user1", "password": "pass123"}])
);

-- OTPs table: Temporary storage for email verification codes
-- Zero-knowledge: Codes are short-lived and not linked to sensitive data
CREATE TABLE otps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME DEFAULT (CURRENT_TIMESTAMP + INTERVAL 10 MINUTE),
    INDEX idx_email (email),
    INDEX idx_expires (expires_at)
);

-- Optional: Cleanup procedure for expired OTPs
DELIMITER //
CREATE PROCEDURE cleanup_expired_otps()
BEGIN
    DELETE FROM otps WHERE expires_at < NOW();
END //
DELIMITER ;