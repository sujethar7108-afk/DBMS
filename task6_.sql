CREATE DATABASE ProductReviewDB;
USE ProductReviewDB;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15)
);
INSERT INTO Customers VALUES
(1, 'Arun Kumar', 'arun@gmail.com', '9876543210'),
(2, 'Priya Sharma', 'priya@gmail.com', '9876543211'),
(3, 'Rahul Raj', 'rahul@gmail.com', '9876543212'),
(4, 'Divya Singh', 'divya@gmail.com', '9876543213'),
(5, 'Karthik M', 'karthik@gmail.com', '9876543214');
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);
INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Smartphones'),
(3, 'Accessories'),
(4, 'Laptops'),
(5, 'Tablets');
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);
INSERT INTO Products VALUES
(101, 'HP Laptop', 4, 55000.00),
(102, 'Samsung Galaxy S24', 2, 75000.00),
(103, 'Sony Headphones', 3, 8000.00),
(104, 'Apple iPad', 5, 45000.00),
(105, 'Logitech Mouse', 3, 1500.00);
INSERT INTO Reviews VALUES
(1, 101, 1, 5, 'Excellent laptop', '2026-09-01'),
(2, 101, 2, 4, 'Good performance', '2026-09-02'),
(3, 102, 3, 5, 'Amazing smartphone', '2026-09-03'),
(4, 102, 4, 4, 'Very good phone', '2026-09-04'),
(5, 103, 1, 3, 'Good sound quality', '2026-09-05'),
(6, 104, 2, 5, 'Excellent tablet', '2026-09-06'),
(7, 105, 5, 4, 'Good mouse', '2026-09-07');

CREATE TABLE Review_Replies (
    reply_id INT PRIMARY KEY,
    review_id INT,
    reply_text VARCHAR(500),
    reply_date DATE,
    FOREIGN KEY (review_id)
        REFERENCES Reviews(review_id)
);
INSERT INTO Review_Replies VALUES
(1, 1, 'Thank you for your valuable review.', '2026-09-02'),
(2, 2, 'Thank you for your feedback.', '2026-09-03'),
(3, 3, 'We are happy you liked the product.', '2026-09-04'),
(4, 5, 'Thank you for your suggestion.', '2026-09-06'),
(5, 6, 'Thank you for your positive review.', '2026-09-07');

SELECT * FROM Customers;

SELECT * FROM Categories;
SELECT
    r.review_id,
    p.product_name,
    c.customer_name,
    r.rating,
    r.review_text,
    r.review_date
FROM Reviews r
JOIN Products p
ON r.product_id = p.product_id
JOIN Customers c
ON r.customer_id = c.customer_id;

SELECT
    rr.reply_id,
    r.review_id,
    p.product_name,
    rr.reply_text,
    rr.reply_date
FROM Review_Replies rr
JOIN Reviews r
ON rr.review_id = r.review_id
JOIN Products p
ON r.product_id = p.product_id;

