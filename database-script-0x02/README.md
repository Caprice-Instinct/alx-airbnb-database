# Database Seed Script

## Overview
This directory contains the SQL script used to populate the Airbnb-like database with **sample data**.  
The data simulates real-world usage, including multiple users (hosts, guests, admin), properties, bookings, payments, and reviews.

The SQL file is:  
**`seed.sql`**

---

## Seeded Tables

### 1. Users
Five users are added:
- Guests: Alice, Carol
- Hosts: Bob, David
- Admin: Admin User

### 2. Properties
Three properties listed by hosts:
- Cozy Apartment in Nairobi (hosted by Bob)
- Beach House in Mombasa (hosted by Bob)
- Mountain Cabin in Nyeri (hosted by David)

### 3. Bookings
Three bookings created:
- Alice booked Bob’s apartment (confirmed)
- Carol booked Bob’s beach house (pending)
- Alice booked David’s cabin (cancelled)

### 4. Payments
Each booking has one payment record:
- Successful M-Pesa payment for Alice’s booking
- Pending card payment for Carol’s booking
- Failed PayPal payment for Alice’s cancelled booking

### 5. Reviews
Two reviews added:
- Positive review from Alice (5 stars)
- Low rating on a cancelled booking (2 stars)

---

## Notes
- Dates are set in the future (September–October 2025).
- Payments and reviews are linked to valid bookings.
- This data provides a realistic test set for queries and application development.

---
