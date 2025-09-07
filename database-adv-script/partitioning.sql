-- Assume the Booking table is large and query performance is slow. Implement partitioning on the Booking table based on the start_date column
CREATE TABLE Bookings (
    id INT PRIMARY KEY,
    property_id INT,
    user_id INT,
    start_date DATE,
    end_date DATE
)
PARTITION BY RANGE (YEAR(start_date));

CREATE TABLE bookings_y2023 PARTITION OF bookings FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_y2024 PARTITION OF bookings FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Insert sample data for testing
INSERT INTO bookings (property_id, user_id, start_date, end_date) VALUES
(1, 1, '2023-06-15', '2023-06-20'),
(2, 2, '2023-12-01', '2023-12-05'),
(3, 3, '2024-03-10', '2024-03-15'),
(1, 2, '2024-07-20', '2024-07-25'),
(2, 1, '2024-11-01', '2024-11-05');

-- Performance testing queries
\echo 'PARTITION PERFORMANCE TESTS:'

-- Test 1: Date range query (should use partition pruning)
\echo 'Test 1: Date range query within single partition'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Test 2: Cross-partition query
\echo 'Test 2: Cross-partition date range query'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date BETWEEN '2023-11-01' AND '2024-02-28';

-- Test 3: Specific date query
\echo 'Test 3: Specific date query'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date = '2024-07-20';

-- Test 4: Property-based query with date filter
\echo 'Test 4: Property query with date filter'
EXPLAIN ANALYZE SELECT * FROM bookings WHERE property_id = 1 AND start_date >= '2024-01-01';

-- Show partition pruning in action
\echo 'Partition constraint exclusion info:'
SET constraint_exclusion = partition;
SHOW constraint_exclusion;