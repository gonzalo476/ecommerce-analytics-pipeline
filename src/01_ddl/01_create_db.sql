-- Create database ecommerce_analytics with utf-8 encoding
create database ecommerce_analytics
character set utf8mb4
collate utf8mb4_unicode_ci;

-- select the db
use ecommerce_analytics;

-- verify database
select
    schema_name as database_name,
    default_character_set_name as charset, -- noqa: RF04
    default_collation_name as collation
from information_schema.schemata
where schema_name = 'ecommerce_analytics';
