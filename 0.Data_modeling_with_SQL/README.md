# SQL Data Modeling and Analysis

## Overview

This project uses PostgreSQL as the database management system. The main objectives are to design a relational database schema, import data from CSV files, and perform data analysis to answer specific business questions. The tools and techniques used include entity-relationship diagramming (ERD) tools like [QuickDBD](https://www.quickdatabasediagrams.com/), SQL for data modeling, and analytical queries.

## Repository Structure

```
├── README.md
├── schema.md
├── data
│   ├── employees.csv
│   ├── departments.csv
│   ├── titles.csv
│   ├── salaries.csv
│   ├── dept_emp.csv
│   └── dept_manager.csv
├── SQL
│   ├── erd_solution.sql
│   └── Data_Analysis.sql
└── Images
    └── ERD.png
```

## Task

### Data Modeling & Engineering

1. Use data modeling tools (Quick DBD) for data modeling, create entity-relationship diagrams (ERD).
2. Create the database schema based on the ERD.
3. Import the data from the CSV files into the PostgreSQL database.

### Data Analysis

1. List the employee number, last name, first name, sex, and salary of each employee.
2. List the first name, last name, and hire date for the employees who were hired in 1986.
3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
4. List the department number for each employee along with that employee's employee number, last name, first name, and department name.
5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
6. List each employee in the Sales department, including their employee number, last name, and first name.
7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

## Solution

### Data Modeling

- [Schema](https://github.com/steve-yuan-8276/sql-challenge/blob/main/schema.md)
- [ERD Figure](https://github.com/steve-yuan-8276/SQL_Projects/tree/main/0.Data_modeling_with_SQL/Images)
- [Schema SQL Scripts](https://github.com/steve-yuan-8276/SQL_Projects/blob/main/0.Data_modeling_with_SQL/SQL/Data_Modeling.sql)

### Data Analysis

- [Analysis Queries](https://github.com/steve-yuan-8276/SQL_Projects/blob/main/0.Data_modeling_with_SQL/SQL/Data_Analysis.sql)




