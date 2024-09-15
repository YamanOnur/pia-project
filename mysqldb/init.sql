CREATE DATABASE IF NOT EXISTS dbcontrolservice_db;
CREATE DATABASE IF NOT EXISTS emailservice_db;
CREATE DATABASE IF NOT EXISTS shippingservice_db;
CREATE DATABASE IF NOT EXISTS paymentservice_db;


CREATE USER IF NOT EXISTS 'email_user'@'%' IDENTIFIED BY 'emailpassword';
CREATE USER IF NOT EXISTS 'shipping_user'@'%' IDENTIFIED BY 'shippingpassword';
CREATE USER IF NOT EXISTS 'payment_user'@'%' IDENTIFIED BY 'paymentpassword';


GRANT ALL PRIVILEGES ON emailservice_db.* TO 'email_user'@'%';
GRANT ALL PRIVILEGES ON shippingservice_db.* TO 'shipping_user'@'%';
GRANT ALL PRIVILEGES ON paymentservice_db.* TO 'payment_user'@'%';


USE dbcontrolservice_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shipping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street_address VARCHAR(255) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    credit_card_number VARCHAR(20) NOT NULL,
    expire_year INT NOT NULL,
    expire_month INT NOT NULL,
    cvv VARCHAR(10) NOT NULL,
    status ENUM('pending', 'completed', 'failed') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


USE emailservice_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


USE shippingservice_db;

CREATE TABLE IF NOT EXISTS shipping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street_address VARCHAR(255) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


USE paymentservice_db;

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    credit_card_number VARCHAR(20) NOT NULL,
    expire_year INT NOT NULL,
    expire_month INT NOT NULL,
    cvv VARCHAR(10) NOT NULL,
    status ENUM('pending', 'completed', 'failed') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


FLUSH PRIVILEGES;