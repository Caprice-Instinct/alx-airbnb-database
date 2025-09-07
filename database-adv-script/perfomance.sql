-- Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on perfomance.sql
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.name AS user_name,
    u.email AS user_email,
    p.title AS property_title,
    p.location AS property_location,
    p.price_per_night,
    pay.amount AS payment_amount,
    pay.method AS payment_method,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;


-- Analyze the query's performance using EXPLAIN and identify any inefficiencies
EXPLAIN ANALYZE SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.name AS user_name,
    u.email AS user_email,
    p.title AS property_title,
    p.location AS property_location,
    p.price_per_night,
    pay.amount AS payment_amount,
    pay.method AS payment_method,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

-- Performance Analysis:
-- Look for these inefficiencies in EXPLAIN output:
-- 1. Sequential Scans (Seq Scan) - indicates missing indexes
-- 2. High cost values - expensive operations
-- 3. Nested Loop joins without indexes - slow for large datasets
-- 4. Hash joins on large tables - may need better indexing
-- 5. Sort operations - consider adding ORDER BY indexes

-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.

-- OPTIMIZED VERSION 1: Add indexes for better JOIN performance
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);

-- OPTIMIZED VERSION 2: Select only necessary columns
SELECT 
    b.id,
    b.start_date,
    b.end_date,
    b.status,
    u.name,
    p.title,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

-- OPTIMIZED VERSION 3: Add WHERE clause to limit results
SELECT 
    b.id,
    b.start_date,
    u.name,
    p.title,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.status = 'confirmed'
AND b.start_date >= CURRENT_DATE;

-- Test optimized query performance
EXPLAIN ANALYZE SELECT 
    b.id,
    b.start_date,
    u.name,
    p.title,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.status = 'confirmed';