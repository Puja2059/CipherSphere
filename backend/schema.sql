use ciphersphere;
show tables;
select *from vault;
alter table vault drop column site_url;
alter table vault drop column site_name;
drop table vault;
CREATE TABLE vault (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    user_id INT NOT NULL,
    
    platform VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    encrypted_password TEXT NOT NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
