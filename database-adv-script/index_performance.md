# Database Index Performance Analysis

## Overview
Performance comparison of queries before and after adding indexes to high-usage columns.

## Test Script
Run `performance_test.sql` to measure actual performance with your data.

## Sample Results

### 1. Filter Users by Role
```sql
SELECT * FROM users WHERE role = 'host';
```

**Before Index:**
```
Seq Scan on users (cost=0.00..1.06 rows=2 width=94) (actual time=0.012..0.013 rows=2 loops=1)
Filter: ((role)::text = 'host'::text)
Rows Removed by Filter: 3
Planning Time: 0.063 ms
Execution Time: 0.025 ms
```

**After Index (idx_users_role):**
```
Bitmap Heap Scan on users (cost=4.19..8.20 rows=2 width=94) (actual time=0.015..0.016 rows=2 loops=1)
Recheck Cond: ((role)::text = 'host'::text)
Heap Blocks: exact=1
-> Bitmap Index Scan on idx_users_role (cost=0.00..4.19 rows=2 width=0) (actual time=0.011..0.011 rows=2 loops=1)
     Index Cond: ((role)::text = 'host'::text)
Planning Time: 0.089 ms
Execution Time: 0.030 ms
```

### 2. Find Properties by Location
```sql
SELECT * FROM properties WHERE location = 'Nairobi, Kenya';
```

**Before Index:**
```
Seq Scan on properties (cost=0.00..1.04 rows=1 width=122) (actual time=0.010..0.011 rows=1 loops=1)
Filter: ((location)::text = 'Nairobi, Kenya'::text)
Rows Removed by Filter: 2
Execution Time: 0.023 ms
```

**After Index (existing idx_properties_location):**
```
Index Scan using idx_properties_location on properties (cost=0.15..8.17 rows=1 width=122) (actual time=0.008..0.009 rows=1 loops=1)
Index Cond: ((location)::text = 'Nairobi, Kenya'::text)
Execution Time: 0.018 ms
```

### 3. JOIN Performance
```sql
SELECT b.id, u.name FROM bookings b JOIN users u ON b.user_id = u.id;
```

**Before Additional Indexes:**
```
Hash Join (cost=1.11..2.18 rows=3 width=36) (actual time=0.025..0.027 rows=3 loops=1)
Hash Cond: (b.user_id = u.id)
-> Seq Scan on bookings b (cost=0.00..1.03 rows=3 width=8)
-> Hash (cost=1.05..1.05 rows=5 width=36)
     -> Seq Scan on users u (cost=0.00..1.05 rows=5 width=36)
Execution Time: 0.045 ms
```

**After Indexes:**
```
Nested Loop (cost=0.29..8.38 rows=3 width=36) (actual time=0.018..0.021 rows=3 loops=1)
-> Seq Scan on bookings b (cost=0.00..1.03 rows=3 width=8)
-> Index Scan using users_pkey on users u (cost=0.15..8.17 rows=1 width=36)
     Index Cond: (id = b.user_id)
Execution Time: 0.038 ms
```

## Performance Impact

### Benefits
- **Query Speed**: Index scans are faster than sequential scans for filtered queries
- **JOIN Performance**: Foreign key indexes improve JOIN operation speed
- **Sorting**: Indexes on ORDER BY columns eliminate sorting overhead

### Trade-offs
- **Storage**: Additional disk space required for index storage
- **Write Performance**: Slight overhead on INSERT/UPDATE operations
- **Maintenance**: Indexes require maintenance during data modifications

## Recommendations
1. Monitor query patterns and add indexes for frequently filtered columns
2. Use composite indexes for multi-column WHERE clauses
3. Regularly analyze query performance with EXPLAIN ANALYZE
4. Remove unused indexes to optimize write performance