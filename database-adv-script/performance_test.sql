-- ===============================
-- Performance Testing Script
-- ===============================

-- Test queries BEFORE adding indexes
\echo 'BEFORE INDEXES:'

\echo '1. Filter users by role:'
EXPLAIN ANALYZE SELECT * FROM users WHERE role = 'host';

\echo '2. Find properties by location:'
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'Nairobi, Kenya';

\echo '3. Filter bookings by status:'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE status = 'confirmed';

\echo '4. JOIN bookings with users:'
EXPLAIN ANALYZE SELECT b.id, u.name FROM bookings b JOIN users u ON b.user_id = u.id;

\echo '5. Date range query:'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date >= '2025-09-01' AND end_date <= '2025-10-31';

-- Add the indexes
\i database_index.sql

\echo 'AFTER INDEXES:'

\echo '1. Filter users by role:'
EXPLAIN ANALYZE SELECT * FROM users WHERE role = 'host';

\echo '2. Find properties by location:'
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'Nairobi, Kenya';

\echo '3. Filter bookings by status:'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE status = 'confirmed';

\echo '4. JOIN bookings with users:'
EXPLAIN ANALYZE SELECT b.id, u.name FROM bookings b JOIN users u ON b.user_id = u.id;

\echo '5. Date range query:'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date >= '2025-09-01' AND end_date <= '2025-10-31';