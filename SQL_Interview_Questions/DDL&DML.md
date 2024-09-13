# What's DDL and DML?

## DDL (Data Definition Language)

DDL is used to define and manage the structure of a database schema, including the creation, alteration, and deletion of database objects like tables, indexes, and views.

### 1. CREATE
Used to create new objects in the database, such as tables, views, or indexes.
```sql
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
    ...
);
```

### 2. ALTER
Used to modify existing database objects.
- **Adding a column**:
    ```sql
    ALTER TABLE table_name
    ADD column_name datatype;
    ```

- **Modifying a column**:
    ```sql
    ALTER TABLE table_name
    MODIFY column_name new_datatype;
    ```

- **Dropping a column**:
    ```sql
    ALTER TABLE table_name
    DROP COLUMN column_name;
    ```

### 3. DROP
Used to delete objects from the database.
```sql
DROP TABLE table_name;
```

### 4. TRUNCATE
Used to remove all records from a table, but the table itself remains.
```sql
TRUNCATE TABLE table_name;
```

### 5. RENAME
Used to rename database objects such as tables.
```sql
RENAME TABLE old_table_name TO new_table_name;
```



## DML (Data Manipulation Language)

DML is used for managing data within database tables. It includes commands for selecting, inserting, updating, and deleting data.

### 1. SELECT
Retrieves data from one or more tables.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

### 2. INSERT
Adds new rows of data into a table.
```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

### 3. UPDATE
Modifies existing data within a table.
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### 4. DELETE
Removes data from a table based on a condition.
```sql
DELETE FROM table_name
WHERE condition;
```
