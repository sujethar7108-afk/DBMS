CREATE DATABASE PaymentTransactionDB;
USE PaymentTransactionDB;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15)
);
INSERT INTO Customers
(customer_id, customer_name, email, phone)
VALUES
(1, 'Arun Kumar', 'arun@gmail.com', '9876543210'),
(2, 'Priya Sharma', 'priya@gmail.com', '9876543211'),
(3, 'Rahul Raj', 'rahul@gmail.com', '9876543212'),
(4, 'Divya Singh', 'divya@gmail.com', '9876543213'),
(5, 'Karthik M', 'karthik@gmail.com', '9876543214');
CREATE TABLE Payment_Methods (
    method_id INT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    provider VARCHAR(100)
);
INSERT INTO Payment_Methods
(method_id, method_name, provider)
VALUES
(1, 'Credit Card', 'Visa'),
(2, 'Debit Card', 'MasterCard'),
(3, 'UPI', 'Google Pay'),
(4, 'Net Banking', 'SBI'),
(5, 'Wallet', 'Paytm');
CREATE TABLE Merchants (
    merchant_id INT PRIMARY KEY,
    merchant_name VARCHAR(100) NOT NULL,
    business_type VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Transaction_Logs (
    log_id INT PRIMARY KEY,
    transaction_id INT,
    log_message VARCHAR(300),
    log_date DATE,

    FOREIGN KEY (transaction_id)
    REFERENCES Transactions(transaction_id)
);
SELECT
    c.customer_id,
    c.customer_name,
    c.email,

    pm.method_id,
    pm.method_name,
    pm.provider,

    m.merchant_id,
    m.merchant_name,
    m.business_type,
    m.location,

    t.transaction_id,
    t.amount,
    t.transaction_date,
    t.status,

    tl.log_id,
    tl.log_message,
    tl.log_date

FROM Customers c

INNER JOIN Transactions t
    ON c.customer_id = t.customer_id

INNER JOIN Payment_Methods pm
    ON t.method_id = pm.method_id

INNER JOIN Merchants m
    ON t.merchant_id = m.merchant_id

LEFT JOIN Transaction_Logs tl
    ON t.transaction_id = tl.transaction_id

ORDER BY t.transaction_id;