-- Create database ecommerce_analytics with utf-8 encoding
CREATE DATABASE ecommerce_analytics
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- select the db
USE ecommerce_analytics;

-- verify database
SELECT
    schema_name AS database_name,
    default_character_set_name AS charset,
    default_collation_name AS collation
FROM information_schema.schemata
WHERE schema_name = 'ecommerce_analytics';
