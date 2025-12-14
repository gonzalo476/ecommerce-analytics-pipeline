-- extract only the products that has an offer in Red color and the weight
USE ecommerce_analytics;
SELECT
    p.product_name,
    p.product_attributes ->> '$.color' AS color,
    p.product_attributes ->> '$.weight_kg' AS weight
FROM products AS p
WHERE
    json_contains(p.product_attributes, '"sale"', '$.tags') = 1
    AND p.product_attributes ->> '$.color' = 'Red';

-- extract only the products with Red color that weights betteen 1 and 2 kg
USE ecommerce_analytics;
SELECT
    p.product_name,
    p.product_attributes ->> '$.color' AS color,
    p.product_attributes ->> '$.weight_kg' AS weight
FROM products AS p
WHERE
    json_contains(p.product_attributes, '"sale"', '$.tags') = 1
    AND p.product_attributes ->> '$.color' = 'Red'
    AND cast(p.product_attributes ->> '$.weight_kg' AS DECIMAL(10, 2)) > 1
    AND cast(p.product_attributes ->> '$.weight_kg' AS DECIMAL(10, 2)) < 2;
