CREATE DATABASE OrderManagementDB2;
USE OrderManagementDB2;
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
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL
);
INSERT INTO Products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 30000.00),
(103, 'Headphones', 'Accessories', 5000.00),
(104, 'Keyboard', 'Accessories', 2000.00),
(105, 'Mouse', 'Accessories', 1500.00);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    order_date DATE,
    order_status VARCHAR(30),

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id),

    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
INSERT INTO Orders
(order_id, customer_id, product_id, quantity,
 order_date, order_status)
VALUES
(1001, 1, 101, 1, '2026-09-01', 'Delivered'),
(1002, 2, 102, 1, '2026-09-02', 'Processing'),
(1003, 3, 103, 1, '2026-09-03', 'Shipped'),
(1004, 4, 101, 1, '2026-09-04', 'Delivered'),
(1005, 5, 102, 1, '2026-09-05', 'Pending');
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_address VARCHAR(200),
    courier VARCHAR(100),
    tracking_number VARCHAR(100),
    shipping_status VARCHAR(30),

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);
INSERT INTO Shipping
(shipping_id, order_id, shipping_address,
 courier, tracking_number, shipping_status)
VALUES
(501, 1001, 'Chennai, Tamil Nadu', 'BlueDart', 'BD10001', 'Delivered'),
(502, 1002, 'Bangalore, Karnataka', 'Delhivery', 'DL10002', 'Processing'),
(503, 1003, 'Hyderabad, Telangana', 'DTDC', 'DT10003', 'Shipped'),
(504, 1004, 'Mumbai, Maharashtra', 'BlueDart', 'BD10004', 'Delivered'),
(505, 1005, 'Delhi, India', 'Delhivery', 'DL10005', 'Pending');
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    payment_date DATE,

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);
INSERT INTO Payments
(payment_id, order_id, payment_method,
 payment_amount, payment_status, payment_date)
VALUES
(601, 1001, 'UPI', 55000.00, 'Paid', '2026-09-01'),
(602, 1002, 'Credit Card', 30000.00, 'Paid', '2026-09-02'),
(603, 1003, 'Debit Card', 5000.00, 'Paid', '2026-09-03'),
(604, 1004, 'Net Banking', 55000.00, 'Paid', '2026-09-04'),
(605, 1005, 'UPI', 30000.00, 'Pending', '2026-09-05');
SELECT
    c.customer_id,
    c.customer_name,
    c.email,

    o.order_id,
    o.order_date,
    o.order_status,

    p.product_id,
    p.product_name,
    p.category,
    p.price,
    o.quantity,

    (p.price * o.quantity) AS total_amount,

    s.shipping_id,
    s.shipping_address,
    s.courier,
    s.tracking_number,
    s.shipping_status,

    pay.payment_id,
    pay.payment_method,
    pay.payment_amount,
    pay.payment_status,
    pay.payment_date

FROM Customers c

INNER JOIN Orders o
    ON c.customer_id = o.customer_id

INNER JOIN Products p
    ON o.product_id = p.product_id

LEFT JOIN Shipping s
    ON o.order_id = s.order_id

LEFT JOIN Payments pay
    ON o.order_id = pay.order_id

ORDER BY o.order_id;
