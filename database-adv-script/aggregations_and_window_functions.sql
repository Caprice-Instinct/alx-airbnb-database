-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT COUNT(*) FROM Bookings GROUP BY user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT p.id, p.name, COUNT(b.id) AS TotalBookings, RANK() OVER (ORDER BY COUNT(b.id) DESC) AS BookingRank
FROM Properties p
LEFT JOIN Bookings b ON p.id = b.property_id
GROUP BY p.id, p.name;
