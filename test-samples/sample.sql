-- ============================================
-- Theme Check: SQL
-- ============================================
-- - Keywords (SELECT, FROM, WHERE, JOIN, etc.)
-- - Built-in functions (COUNT, SUM, COALESCE)
-- - Strings and numbers
-- - Operators and comparisons
-- - Comments (single line, block)
-- - Data types

/* Block comment:
   Schema definition for a user management system. */

-- --- Table creation ---
CREATE TABLE users (
    id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    email       VARCHAR(255) UNIQUE NOT NULL,
    is_active   BOOLEAN DEFAULT TRUE,
    balance     DECIMAL(10, 2) DEFAULT 0.00,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users (email);

-- --- Insert ---
INSERT INTO users (name, email, is_active, balance)
VALUES
    ('Alice', 'alice@example.com', TRUE, 100.50),
    ('Bob', 'bob@example.com', FALSE, 0.00),
    ('Carol', 'carol@example.com', TRUE, 2500.75);

-- --- Select with joins, aggregates, conditions ---
SELECT
    u.id,
    u.name,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(o.total), 0) AS total_spent,
    CASE
        WHEN SUM(o.total) > 1000 THEN 'VIP'
        WHEN SUM(o.total) > 100  THEN 'Regular'
        ELSE 'New'
    END AS tier
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
WHERE u.is_active = TRUE
    AND u.created_at >= '2024-01-01'
    AND u.email LIKE '%@example.com'
GROUP BY u.id, u.name
HAVING COUNT(o.id) > 0
ORDER BY total_spent DESC
LIMIT 10;

-- --- Update ---
UPDATE users
SET balance = balance * 1.05,
    is_active = TRUE
WHERE id IN (SELECT user_id FROM premium_subscriptions);

-- --- Common Table Expression ---
WITH active_users AS (
    SELECT id, name FROM users WHERE is_active = TRUE
)
SELECT au.name, COUNT(*) AS sessions
FROM active_users au
INNER JOIN sessions s ON s.user_id = au.id
GROUP BY au.name;

-- --- Delete ---
DELETE FROM users
WHERE is_active = FALSE
    AND balance = 0.00;
