# Expected Partition Performance Results

## Test 1: Single Partition Query

```sql
SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```

**Expected Output:**

```
Append (cost=0.00..41.88 rows=13 width=20)
  -> Seq Scan on bookings_y2024 (cost=0.00..41.88 rows=13 width=20)
       Filter: (start_date >= '2024-01-01' AND start_date <= '2024-12-31')
Execution time: 0.123 ms
```

**Result:** Only scans bookings_y2024 partition (partition pruning working)

## Test 2: Cross-Partition Query

```sql
SELECT * FROM bookings WHERE start_date BETWEEN '2023-11-01' AND '2024-02-28';
```

**Expected Output:**

```
Append (cost=0.00..83.76 rows=26 width=20)
  -> Seq Scan on bookings_y2023 (cost=0.00..41.88 rows=13 width=20)
       Filter: (start_date >= '2023-11-01' AND start_date <= '2024-02-28')
  -> Seq Scan on bookings_y2024 (cost=0.00..41.88 rows=13 width=20)
       Filter: (start_date >= '2023-11-01' AND start_date <= '2024-02-28')
Execution time: 0.245 ms
```

**Result:** Scans both partitions as date range spans across them

## Test 3: Specific Date Query

```sql
SELECT * FROM bookings WHERE start_date = '2024-07-20';
```

**Expected Output:**

```
Append (cost=0.00..41.88 rows=1 width=20)
  -> Seq Scan on bookings_y2024 (cost=0.00..41.88 rows=1 width=20)
       Filter: (start_date = '2024-07-20')
Execution time: 0.089 ms
```

**Result:** Only scans 2024 partition (optimal pruning)

## Performance Benefits

- **Partition Pruning**: Eliminates unnecessary partition scans
- **Reduced I/O**: Only relevant data blocks are read
- **Faster Queries**: Smaller data sets to scan per partition
- **Parallel Processing**: Each partition can be processed independently
