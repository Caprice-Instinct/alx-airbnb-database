# Airbnb Database Requirements

## 1. Introduction
This database is designed for an Airbnb-like application.  
It manages users (hosts and guests), properties, bookings, and payments.  
The goal is to ensure data integrity, avoid redundancy, and support scalable queries for real-world usage.

---

## 2. Entities and Attributes

### User
- **user_id** (PK)
- name
- email (unique)
- phone
- role (guest, host, admin)
- created_at

### Property
- **property_id** (PK)
- host_id (FK → User.user_id)
- title
- description
- location
- price_per_night
- created_at

### Booking
- **booking_id** (PK)
- user_id (FK → User.user_id)
- property_id (FK → Property.property_id)
- start_date
- end_date
- status (pending, confirmed, cancelled)

### Payment
- **payment_id** (PK)
- booking_id (FK → Booking.booking_id)
- amount
- method (card, mobile_money, PayPal, etc.)
- status (successful, failed, pending)
- created_at

*(Optional: You may also add entities like `Review`, `Amenity`, `Message`, depending on how complex you want your design.)*

---

## 3. Relationships
- A **User** (host) can create many **Properties**.
- A **User** (guest) can make many **Bookings**.
- A **Property** can have many **Bookings**.
- A **Booking** must belong to one **User** and one **Property**.
- A **Booking** can have exactly one **Payment**.

---

## 4. Business Rules & Constraints
- A property must always belong to a valid host (role = host).
- A booking cannot exist without a valid property and guest.
- A booking’s end_date must be after its start_date.
- A payment must always be tied to a booking.
- Emails in the User table must be unique.
- Prices and payment amounts must be greater than zero.

---

## 5. ER Diagram
The ER diagram illustrating these entities and relationships is saved as:  
**`ERD/airbnb_erd.png`**

---
