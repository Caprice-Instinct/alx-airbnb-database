-- ===============================
-- Database Performance Indexes
-- ===============================

-- Performance measurement BEFORE adding indexes
\echo 'PERFORMANCE BEFORE INDEXES:'
EXPLAIN ANALYZE SELECT * FROM users WHERE role = 'host';
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'Nairobi, Kenya';
EXPLAIN ANALYZE SELECT * FROM bookings WHERE status = 'confirmed';
EXPLAIN ANALYZE SELECT b.id, u.name FROM bookings b JOIN users u ON b.user_id = u.id;

-- Additional indexes for high-usage columns beyond those in schema.sql

-- USERS TABLE
-- Index on role for filtering by user type (guest, host, admin)
CREATE INDEX idx_users_role ON users(role);

-- PROPERTIES TABLE  
-- Index on host_id for JOIN operations and filtering by host
CREATE INDEX idx_properties_host_id ON properties(host_id);
-- Composite index for location and price filtering
CREATE INDEX idx_properties_location_price ON properties(location, price_per_night);

-- BOOKINGS TABLE
-- Index on status for filtering bookings by status
CREATE INDEX idx_bookings_status ON bookings(status);
-- Index on start_date for date range queries
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
-- Composite index for date range queries
CREATE INDEX idx_bookings_date_range ON bookings(start_date, end_date);

-- PAYMENTS TABLE
-- Index on status for payment status filtering
CREATE INDEX idx_payments_status ON payments(status);
-- Index on method for payment method analysis
CREATE INDEX idx_payments_method ON payments(method);

-- REVIEWS TABLE
-- Index on booking_id for JOIN operations (if not already unique)
CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);

-- Performance measurement AFTER adding indexes
\echo 'PERFORMANCE AFTER INDEXES:'
EXPLAIN ANALYZE SELECT * FROM users WHERE role = 'host';
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'Nairobi, Kenya';
EXPLAIN ANALYZE SELECT * FROM bookings WHERE status = 'confirmed';
EXPLAIN ANALYZE SELECT b.id, u.name FROM bookings b JOIN users u ON b.user_id = u.id;