-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * FROM bookings INNER JOIN users ON bookings.user_id = users.id;

-- Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT p.id, p.title, r.rating, r.comment 
FROM properties p 
LEFT JOIN bookings b ON p.id = b.property_id 
LEFT JOIN reviews r ON b.id = r.booking_id;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT u.id, u.name, b.id, b.property_id FROM users u FULL OUTER JOIN bookings b on u.id = b.user_id;