-- create activity_logs indexes
USE ecommerce_analytics;
CREATE INDEX idx_timestamp ON activity_logs (event_timestamp);
CREATE INDEX idx_user_timestamp ON activity_logs (user_id, event_timestamp);


-- check indexes
USE ecommerce_analytics;
SELECT
    table_name,
    index_name,
    column_name,
    seq_in_index,
    non_unique,
    index_type
FROM information_schema.statistics
WHERE
    table_schema = 'ecommerce_analytics'
    AND index_name != 'PRIMARY'
ORDER BY table_name, index_name, seq_in_index;
