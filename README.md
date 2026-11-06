# Library Management System | MySQL

A relational database practice project for managing library branches, employees, books, customers, issued books and returns.

## Database design

The script creates six tables:

| Table | Purpose |
|---|---|
| `Branch` | Branch location and manager |
| `Employee` | Employees assigned to branches |
| `Books` | Book catalogue and rental price |
| `Customer` | Registered library customers |
| `IssueStatus` | Book issue transactions |
| `ReturnStatus` | Book return transactions |

Primary and foreign keys model the relationships. Branch manager references are assigned after employee rows are inserted, then constrained to valid employee IDs.

## Business queries

The SQL script demonstrates:
1. Available books.
2. Employees ordered by salary.
3. Books issued by customers.
4. Book counts by category.
5. Employees above a salary threshold.
6. Customers registered before a date who have not issued books.
7. Employees per branch.
8. Customers who issued books in a selected month.
9. Book-title pattern matching.
10. Branches above an employee-count threshold.
11. Branch managers and branch addresses.
12. Customers who issued books above a rental-price threshold.

## Run locally

1. Install MySQL Server and MySQL Workbench.
2. Open `Library_Management_System_SQL.sql`.
3. Execute the script in a fresh MySQL environment.
4. Inspect the result sets produced by each query.

The script creates a database named `library`. If that database already exists, remove or rename it before running the setup script again.

## Data note

The included records are synthetic demonstration data. Contact numbers use dummy values and are not real contact details.

## Screenshots

The `Screenshots/` directory contains query-output captures from the original exercise.

## Author

Ashiba B

[LinkedIn](https://www.linkedin.com/in/ashiba-data-analyst) · [GitHub](https://github.com/ash-sheik)
