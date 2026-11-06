CREATE DATABASE library;
USE library;

-- Branch manager IDs reference Employee.Emp_Id after Employee is created.
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10,2),
    Status VARCHAR(3),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Demonstration records are synthetic and for SQL practice only.
INSERT INTO Branch VALUES
(1, NULL, 'MG Road, Bangalore', '0000000001'),
(2, NULL, 'Anna Nagar, Chennai', '0000000002'),
(3, NULL, 'Park Street, Kolkata', '0000000003');

INSERT INTO Employee VALUES
(201, 'Ravi Kumar', 'Manager', 70000, 1),
(202, 'Sita Devi', 'Assistant', 40000, 1),
(203, 'Arjun Singh', 'Manager', 65000, 2),
(204, 'Meena Joshi', 'Clerk', 30000, 3),
(205, 'Raj Patel', 'Manager', 55000, 3);

-- Assign managers after employee records exist, then enforce the relationship.
UPDATE Branch SET Manager_Id = 201 WHERE Branch_no = 1;
UPDATE Branch SET Manager_Id = 203 WHERE Branch_no = 2;
UPDATE Branch SET Manager_Id = 205 WHERE Branch_no = 3;

ALTER TABLE Branch
ADD CONSTRAINT fk_branch_manager
FOREIGN KEY (Manager_Id) REFERENCES Employee(Emp_Id);

INSERT INTO Books VALUES
(111, 'History of India', 'History', 30, 'yes', 'Bipin Chandra', 'Oxford'),
(112, 'Modern Physics', 'Science', 40, 'yes', 'H.C. Verma', 'Pearson'),
(113, 'Python Basics', 'Programming', 50, 'no', 'John Zelle', 'Wiley'),
(114, 'World History', 'History', 35, 'yes', 'Norman Lowe', 'McGraw Hill'),
(115, 'Database Systems', 'Technology', 60, 'no', 'Ramez Elmasri', 'Pearson');

INSERT INTO Customer VALUES
(301, 'Anjali Sharma', 'Delhi', '2021-12-20'),
(302, 'Vikram Rao', 'Mumbai', '2022-03-15'),
(303, 'Sneha Iyer', 'Chennai', '2020-11-10'),
(304, 'Amit Das', 'Kolkata', '2023-06-12');

INSERT INTO IssueStatus VALUES
(401, 302, 'Python Basics', '2023-06-05', 113),
(402, 304, 'World History', '2023-06-20', 114);

INSERT INTO ReturnStatus VALUES
(501, 302, 'Python Basics', '2023-07-10', 113);

-- 1. Available books
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. Employees by salary
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Books issued and the customers who issued them
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Number of books by category
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. Employees earning above 50,000
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. Customers registered before 2022 who have not issued books
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Employees per branch
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Customers who issued books in June 2023
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

-- 9. Books with "history" in the title
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10. Branches with more than five employees (no sample branch meets this threshold)
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11. Branch managers and their branch addresses
SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

-- 12. Customers who issued books priced above 25
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;
