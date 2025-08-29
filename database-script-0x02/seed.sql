-- ===============================
-- Airbnb-like Database Sample Data
-- ===============================

-- USERS
INSERT INTO users (name, email, phone, role) VALUES
('Alice Johnson', 'alice@example.com', '+254700000001', 'guest'),
('Bob Smith', 'bob@example.com', '+254700000002', 'host'),
('Carol White', 'carol@example.com', '+254700000003', 'guest'),
('David Kim', 'david@example.com', '+254700000004', 'host'),
('Admin User', 'admin@example.com', '+254700000005', 'admin');

-- PROPERTIES
INSERT INTO properties (host_id, title, description, location, price_per_night) VALUES
(2, 'Cozy Apartment in Nairobi', 'A two-bedroom apartment near CBD with free WiFi.', 'Nairobi, Kenya', 45.00),
(2, 'Beach House', 'Beautiful beachside house with ocean view.', 'Mombasa, Kenya', 120.00),
(4, 'Mountain Cabin', 'Secluded cabin with fireplace in the Aberdares.', 'Nyeri, Kenya', 75.00);

-- BOOKINGS
INSERT INTO bookings (user_id, property_id, start_date, end_date, status) VALUES
(1, 1, '2025-09-05', '2025-09-07', 'confirmed'),
(3, 2, '2025-09-10', '2025-09-14', 'pending'),
(1, 3, '2025-10-01', '2025-10-03', 'cancelled');

-- PAYMENTS
INSERT INTO payments (booking_id, amount, method, status) VALUES
(1, 90.00, 'mobile_money', 'successful'),
(2, 480.00, 'card', 'pending'),
(3, 150.00, 'paypal', 'failed');

-- REVIEWS
INSERT INTO reviews (booking_id, rating, comment) VALUES
(1, 5, 'Amazing stay! The apartment was clean and well located.'),
(3, 2, 'Had to cancel last minute, but communication could have been better.');
