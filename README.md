# Healthcare-SQL-Assignment
# Healthcare Database SQL Queries

## Overview
This repository contains SQL scripts for managing and querying a healthcare database. The scripts are categorized into:

1. Stored Procedures (`stored_procedures.sql`) 
   Includes procedures and queries that modify data (INSERT, UPDATE, DELETE). Example: adding new doctors or patients.

2. CTEs (`ctes.sql`)  
   Queries that use Common Table Expressions, ranking, and aggregation.

3. Regular Queries (`queries.sql`)
   Data retrieval queries using SELECT statements for reporting and analysis.

## Tables Involved
- patients
- doctors
- appointments
- treatments
- bills
- admissions
- prescriptions

## Usage
1. Run queries in the appropriate SQL script based on their category.
2. Ensure foreign key relationships are respected when inserting, updating, or deleting data.
3. CTEs can be used for reporting and analytical purposes without modifying underlying tables.

## Notes
- 
- Some queries rely on window functions (`RANK()`) and aggregation functions (SUM, COUNT, AVG).
