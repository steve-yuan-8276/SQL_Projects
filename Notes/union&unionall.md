# What's the difference between union and union all?

The key difference between `UNION` and `UNION ALL` in SQL relates to how they handle duplicate rows:

1. **`UNION`**:
   - **Removes duplicates**: `UNION` combines the results of two or more `SELECT` statements and automatically removes any duplicate rows in the final result set.
   - **Performance impact**: Since `UNION` performs an extra step to eliminate duplicates, it can be **slower** compared to `UNION ALL`, especially with large datasets.
   
   Example:
   ```sql
   SELECT col1 FROM table1
   UNION
   SELECT col1 FROM table2;
   ```
   This query will return distinct values from `table1` and `table2`.

2. **`UNION ALL`**:
   - **Includes duplicates**: `UNION ALL` combines the results of two or more `SELECT` statements **without removing duplicates**. It returns all rows, including any duplicates present in the result sets.
   - **Performance advantage**: Because `UNION ALL` does not need to check for duplicates, it is generally **faster** and more efficient than `UNION`.

   Example:
   ```sql
   SELECT col1 FROM table1
   UNION ALL
   SELECT col1 FROM table2;
   ```
   This query will return all values, including duplicates, from `table1` and `table2`.

### When to Use:
- Use **`UNION`** when you want only distinct records in your result set.
- Use **`UNION ALL`** when you need all records, including duplicates, or when performance is a concern and you are certain that there are no duplicates in the data.

### Performance Consideration:
`UNION` can take more time due to the sorting or hashing required to eliminate duplicates, whereas `UNION ALL` is faster because it skips this step【45†source】【46†source】.