# Database Schema (DDL)

## Overview
This directory contains the SQL schema for the Airbnb-like database system.  
The schema defines tables, relationships, constraints, and indexes to ensure data integrity, scalability, and optimal query performance.

The SQL file is:  
**`schema.sql`**

---

## Tables and Structure

### 1. Users
Stores all users of the platform (hosts, guests, admins).
- `id` – Primary key
- `name` – Full name
- `email` – Unique email address
- `phone` – Contact number
- `role` – User role (`guest`, `host`, `admin`)
- `created_at` – Timestamp when the user was created

**Indexes**:
- `email` → for fast lookups

---

### 2. Properties
Represents properties listed by hosts.
- `id` – Primary key
- `host_id` – Foreign key → `users.id`
- `title` – Property title
- `description` – Detailed description
- `location` – City/region
- `price_per_night` – Nightly price
- `created_at` – Timestamp when the property was added

**Indexes**:
- `location` → for search queries
- `price_per_night` → for filtering by price

---

### 3. Bookings
Captures booking information when a guest reserves a property.
- `id` – Primary key
- `user_id` – Foreign key → `users.id` (guest making the booking)
- `property_id` – Foreign key → `properties.id`
- `start_date` – Check-in date
- `end_date` – Check-out date
- `status` – Booking status (`pending`, `confirmed`, `cancelled`)
- `created_at` – Timestamp of booking creation

**Constraints**:
- `end_date > start_date` → Valid booking period

**Indexes**:
- `user_id` and `property_id` → for join performance

---

### 4. Payments
Handles payments made for bookings.
- `id` – Primary key
- `booking_id` – Foreign key → `bookings.id` (one-to-one)
- `amount` – Payment amount
- `method` – Payment method (`card`, `mobile_money`, `paypal`, `other`)
- `status` – Payment status (`successful`, `failed`, `pending`)
- `created_at` – Timestamp of payment

**Constraint**:
- One payment per booking (`booking_id` is unique)

---

### 5. Reviews
Stores guest reviews for completed bookings.
- `id` – Primary key
- `booking_id` – Foreign key → `bookings.id` (one-to-one)
- `rating` – Rating value (1–5)
- `comment` – Optional text feedback
- `created_at` – Timestamp of review

**Constraint**:
- One review per booking (`booking_id` is unique)

**Indexes**:
- `rating` → for quick filtering (e.g., average ratings)

---

## Relationships
- One **User** (host) → Many **Properties**
- One **User** (guest) → Many **Bookings**
- One **Property** → Many **Bookings**
- One **Booking** → One **Payment**
- One **Booking** → One **Review**

---

## Notes
- All tables use `SERIAL` primary keys (auto-incrementing integers).
- Timestamps default to the current time.
- Foreign keys use `ON DELETE CASCADE` to ensure referential integrity when records are removed.
- Indexes have been added to improve performance on frequent queries.

---
