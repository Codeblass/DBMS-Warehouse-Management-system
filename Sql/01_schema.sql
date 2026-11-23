CREATE DATABASE IF NOT EXISTS warehouse_management;
USE warehouse_management;

-- 1. Core Superclass Entity (ISA Hierarchy)
CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

-- 2. Subclass: Buyer
CREATE TABLE BUYER (
    Customer_ID INT PRIMARY KEY,
    Preferred_Payment_Method VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

-- 3. Subclass: Seller
CREATE TABLE SELLER (
    Customer_ID INT PRIMARY KEY,
    Rating DECIMAL(2,1),
    Seller_Type VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

-- 4. Product Catalog
CREATE TABLE PRODUCT (
    Product_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL
);

-- 5. Warehouse Facilities
CREATE TABLE WAREHOUSE (
    Warehouse_ID INT PRIMARY KEY,
    Location VARCHAR(100) NOT NULL,
    Capacity INT NOT NULL
);

-- 6. Delivery Personnel
CREATE TABLE DELIVERY_AGENT (
    Agent_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);

-- 7. Buyer Orders
CREATE TABLE ORDER_TABLE (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Status VARCHAR(50),
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES BUYER(Customer_ID)
);

-- 8. Aggregated Entity: Ships (Links Warehouse & Order)
CREATE TABLE SHIPS (
    Shipment_ID INT PRIMARY KEY,
    Warehouse_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    Dispatch_Time TIMESTAMP,
    Current_Location VARCHAR(100),
    Status VARCHAR(50),
    FOREIGN KEY (Warehouse_ID) REFERENCES WAREHOUSE(Warehouse_ID),
    FOREIGN KEY (Order_ID) REFERENCES ORDER_TABLE(Order_ID)
);

-- 9. Shipment Tracking Logs
CREATE TABLE TRACKING_UPDATE (
    Update_ID INT PRIMARY KEY,
    Shipment_ID INT NOT NULL,
    Location VARCHAR(100),
    Timestamp TIMESTAMP,
    Status VARCHAR(50),
    FOREIGN KEY (Shipment_ID) REFERENCES SHIPS(Shipment_ID)
);

-- 10. Relationship: Order Contains Products
CREATE TABLE CONTAINS (
    Order_ID INT,
    Product_ID INT,
    Quantity INT NOT NULL,
    Price_at_order DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES ORDER_TABLE(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
);

-- 11. Relationship: Seller Lists Products
CREATE TABLE LISTS (
    Seller_ID INT,
    Product_ID INT,
    Listing_Date DATE,
    PRIMARY KEY (Seller_ID, Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES SELLER(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
);

-- 12. Relationship: Seller Supplies Warehouse
CREATE TABLE SUPPLIES (
    Customer_ID INT,
    Warehouse_ID INT,
    Supply_Time TIMESTAMP,
    Quantity INT NOT NULL,
    PRIMARY KEY (Customer_ID, Warehouse_ID, Supply_Time),
    FOREIGN KEY (Customer_ID) REFERENCES SELLER(Customer_ID),
    FOREIGN KEY (Warehouse_ID) REFERENCES WAREHOUSE(Warehouse_ID)
);

-- 13. Relationship: Warehouse Stores Products
CREATE TABLE STORES (
    Warehouse_ID INT,
    Product_ID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (Warehouse_ID, Product_ID),
    FOREIGN KEY (Warehouse_ID) REFERENCES WAREHOUSE(Warehouse_ID),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
);

-- 14. Relationship: Delivery Agent Handles Shipments
CREATE TABLE HANDLES (
    Agent_ID INT,
    Shipment_ID INT,
    Assigned_Time TIMESTAMP,
    PRIMARY KEY (Agent_ID, Shipment_ID),
    FOREIGN KEY (Agent_ID) REFERENCES DELIVERY_AGENT(Agent_ID),
    FOREIGN KEY (Shipment_ID) REFERENCES SHIPS(Shipment_ID)
);
