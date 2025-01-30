# Employee Data Queries (SQLite)

This repository contains SQL queries written specifically for **SQLite** to retrieve and analyze employee data from a database.

## Queries Overview

### 1. **JOB1 Query**
- Retrieves the most recent active employment record for a specific employee (EMPLID: `102030`).
- Orders records by `Effective Date` and `Effective Sequence` to ensure the latest record is selected.

### 2. **JOB2 First Query**
- Retrieves the most recent active employment records for all employees.
- Each employee can have multiple active records.
- Includes details such as:
  - Employee ID (EMPLID)
  - Employment Record (EMP_RCD)
  - Effective Date (EFFDT)
  - Company Name (Company)
  - Birthdate
  - Current Age (calculated dynamically)
  - Gender (converted from codes to readable format: 'Male' / 'Female')
  - Preferred Phone (selected from the `PERSONAL_PHONE` table)

### 3. **JOB2 Second Query**
- Retrieves a list of all employment records an employee has/had.
- Groups records by `EMPLID` and combines multiple `EMP_RCD` values into a single column using `GROUP_CONCAT()`.

## Database Requirements
- These queries are written **specifically for SQLite**.
- Ensure your database schema includes the required tables:
  - `JOB`
  - `PERSONAL_DATA`
  - `PERSONAL_PHONE`
- Some SQL functions used (e.g., `GROUP_CONCAT`, `strftime`) are SQLite-specific and may not work in other SQL databases without modification.

## Where is QUERY'S themself:
```sh
   https://github.com/TautvydasKre/SEB-interview-queries-SQLite/blob/main/employee_queries.sql
