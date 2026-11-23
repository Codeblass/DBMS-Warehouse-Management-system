USE warehouse_management;

-- Customers
INSERT INTO CUSTOMER VALUES
(1, 'Darshan', 'Roorkee', '9000000001'),
(2, 'Aman', 'Delhi', '9000000002'),
(3, 'Riya', 'Mumbai', '9000000003'),
(4, 'Karan', 'Jaipur', '9000000004'),
(5, 'Neha', 'Pune', '9000000005'),
(6, 'Arjun', 'Chennai', '9000000006'),
(7, 'Simran', 'Kolkata', '9000000007'),
(8, 'Rahul', 'Lucknow', '9000000008'),
(9, 'Priya', 'Bangalore', '9000000009'),
(10, 'Vikas', 'Hyderabad', '9000000010'),
(11, 'Ankit', 'Ahmedabad', '9000000011'),
(12, 'Sneha', 'Chandigarh', '9000000012');

-- Buyers
INSERT INTO BUYER VALUES
(1, 'UPI'),
(3, 'Card'),
(5, 'NetBanking'),
(7, 'UPI'),
(9, 'Card'),
(10, 'UPI'),
(11, 'NetBanking'),
(12, 'Card');

-- Sellers
INSERT INTO SELLER VALUES
(2, 4.5, 'Individual'),
(4, 4.2, 'Business'),
(6, 4.8, 'Individual'),
(8, 4.1, 'Business');

-- Products
INSERT INTO PRODUCT VALUES
(101, 'Laptop', 'Electronics', 60000.00),
(102, 'Phone', 'Electronics', 20000.00),
(103, 'Headphones', 'Electronics', 3000.00),
(104, 'Shoes', 'Fashion', 2500.00),
(105, 'Watch', 'Accessories', 5000.00);

-- Warehouses
INSERT INTO WAREHOUSE VALUES
(201, 'Delhi', 1000),
(202, 'Mumbai', 800);

-- Delivery Agents
INSERT INTO DELIVERY_AGENT VALUES
(301, 'Ravi', '8000000001'),
(302, 'Suresh', '8000000002');

-- Orders
INSERT INTO ORDER_TABLE VALUES
(401, 1, '2026-04-18', 'Shipped', 60000.00),
(402, 3, '2026-04-18', 'Placed', 20000.00),
(403, 5, '2026-04-18', 'Placed', 3000.00),
(404, 7, '2026-04-18', 'Placed', 2500.00),
(405, 9, '2026-04-18', 'Placed', 5000.00);

-- Shipments
INSERT INTO SHIPS VALUES
(501, 201, 401, '2026-04-23 22:06:00', 'Delhi', 'In Transit'),
(502, 201, 402, '2026-04-23 22:06:00', 'Delhi', 'In Transit'),
(503, 202, 403, '2026-04-23 22:06:00', 'Mumbai', 'In Transit'),
(504, 202, 404, '2026-04-23 22:06:00', 'Mumbai', 'In Transit'),
(505, 201, 405, '2026-04-23 22:06:00', 'Delhi', 'In Transit');

-- Tracking Updates
INSERT INTO TRACKING_UPDATE VALUES
(601, 501, 'Delhi', '2026-04-23 22:10:10', 'Dispatched'),
(602, 501, 'Roorkee', '2026-04-23 22:10:10', 'Out for Delivery'),
(603, 502, 'Delhi', '2026-04-23 22:10:10', 'Dispatched'),
(604, 503, 'Mumbai', '2026-04-23 22:10:10', 'Dispatched'),
(605, 504, 'Mumbai', '2026-04-23 22:10:10', 'Dispatched'),
(606, 505, 'Delhi', '2026-04-23 22:10:10', 'Dispatched');

-- Order Line Items (CONTAINS)
INSERT INTO CONTAINS VALUES
(401, 101, 1, 60000.00),
(402, 102, 1, 20000.00),
(403, 103, 1, 3000.00),
(404, 104, 1, 2500.00),
(405, 105, 1, 5000.00);

-- Product Listings (LISTS)
INSERT INTO LISTS VALUES
(2, 101, '2026-04-18'),
(2, 105, '2026-04-18'),
(4, 102, '2026-04-18'),
(6, 103, '2026-04-18'),
(8, 104, '2026-04-18');

-- Seller Supplies to Warehouses (SUPPLIES)
INSERT INTO SUPPLIES VALUES
(2, 201, '2026-04-18 11:00:00', 50),
(2, 201, '2026-04-18 13:00:00', 20),
(4, 201, '2026-04-18 13:00:00', 40),
(6, 202, '2026-04-18 17:00:00', 60),
(8, 202, '2026-04-18 23:00:00', 30);

-- Warehouse Inventory (STORES)
INSERT INTO STORES VALUES
(201, 101, 30),
(201, 102, 25),
(201, 105, 15),
(202, 103, 40),
(202, 104, 20);

-- Delivery Agent Assignments (HANDLES)
INSERT INTO HANDLES VALUES
(301, 501, '2026-04-18 10:01:10'),
(301, 502, '2026-04-18 10:01:10'),
(301, 505, '2026-04-18 10:01:10'),
(302, 503, '2026-04-18 10:01:10'),
(302, 504, '2026-04-18 10:01:10');
