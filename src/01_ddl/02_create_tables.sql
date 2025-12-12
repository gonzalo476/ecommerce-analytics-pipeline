USE ecommerce_analytics;

-- 1.- create categories table
CREATE TABLE categories (
    category_id int AUTO_INCREMENT PRIMARY KEY,
    category_name varchar(100) NOT NULL,
    parent_id int,
    hierarchy_level int DEFAULT 1
);

-- 2.- create users table
CREATE TABLE users (
    user_id int AUTO_INCREMENT PRIMARY KEY,
    email varchar(100) NOT NULL UNIQUE,
    full_name varchar(100),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    referrer_id int,
    country_iso char(2) DEFAULT 'US'
);

-- 3.- create table products
CREATE TABLE products (
    product_id int AUTO_INCREMENT PRIMARY KEY,
    category_id int,
    product_name varchar(200) NOT NULL,
    base_price decimal(10, 2) NOT NULL,
    product_attributes json,
    product_satus enum('ACTIVE', 'DISCONTINUED') DEFAULT 'ACTIVE'
);

-- 4.- create table orders
CREATE TABLE orders (
    order_id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount decimal(12, 2) DEFAULT 0.00,
    order_status enum('PENDING', 'PAID', 'SHIPPED', 'DELIVERED', 'CANCELLED')
);

-- 5.- create table order_details
CREATE TABLE order_details (
    detail_id bigint AUTO_INCREMENT PRIMARY KEY,
    order_id bigint NOT NULL,
    product_id int NOT NULL,
    quantity int NOT NULL CHECK (quantity > 0),
    unit_price decimal(10, 2) NOT NULL
);

-- 6.- create table activity_logs
CREATE TABLE activity_logs (
    log_id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id int,
    event_timestamp DATETIME(6) NOT NULL,
    event_type varchar(50),
    event_metadata json
);
