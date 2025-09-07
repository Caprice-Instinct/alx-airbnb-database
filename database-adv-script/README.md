# Advanced Database Queries

## Overview
This directory contains advanced SQL queries for the Airbnb-like database, focusing on **JOIN operations** to retrieve related data across multiple tables.

The SQL file is:  
**`joins_queries.sql`**

---

## Query Types

### 1. INNER JOIN
**Purpose**: Retrieve bookings with their respective users  
**Use Case**: Get complete booking information including user details for confirmed reservations

### 2. LEFT JOIN  
**Purpose**: Retrieve all properties with their reviews (including properties without reviews)  
**Use Case**: Display property listings with review data, showing properties even if they haven't been reviewed yet

### 3. FULL OUTER JOIN
**Purpose**: Retrieve all users and bookings, including unmatched records  
**Use Case**: Complete data analysis showing all users (even those without bookings) and all bookings (even orphaned ones)

---

## Sample Results
Based on the seeded data:
- **INNER JOIN**: Returns 3 booking records with user information
- **LEFT JOIN**: Shows all 3 properties, with review data where available
- **FULL OUTER JOIN**: Displays all 5 users and 3 bookings with complete relationship mapping

---