-- categories constraints
USE ecommerce_analytics;

ALTER TABLE categories
ADD CONSTRAINT fk_category_parent
FOREIGN KEY (parent_id)
REFERENCES categories (category_id)
ON DELETE SET NULL;

-- users constraints
USE ecommerce_analytics;
ALTER TABLE users
ADD CONSTRAINT fk_user_referrer
FOREIGN KEY (referrer_id)
REFERENCES users (user_id)
ON DELETE SET NULL;

-- products constraints
USE ecommerce_analytics;
ALTER TABLE products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id)
REFERENCES categories (category_id);

-- orders constraints
USE ecommerce_analytics;
ALTER TABLE orders
ADD CONSTRAINT fk_order_user
FOREIGN KEY (user_id)
REFERENCES users (user_id);

-- order details constraints
USE ecommerce_analytics;

ALTER TABLE order_details
ADD CONSTRAINT fk_detail_order
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE CASCADE;

ALTER TABLE order_details
ADD CONSTRAINT fk_detail_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

-- check categories fk constraints
USE ecommerce_analytics;
SELECT
    table_name AS child_table,
    column_name AS child_column,
    constraint_name AS foreign_key,
    referenced_table_name AS parent_table,
    referenced_column_name AS parent_column
FROM information_schema.key_column_usage
WHERE
    table_schema = 'ecommerce_analytics'
    AND table_name = 'order_details'
    AND referenced_table_name IS NOT NULL;
