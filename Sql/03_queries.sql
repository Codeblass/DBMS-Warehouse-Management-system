USE warehouse_management;

-- ============================================================================
-- QUERY 1: Names of all customers
-- RA  : π Name (CUSTOMER)
-- TRC : { c.Name | CUSTOMER(c) }
-- DRC : { n | ∃cid, addr, ph (CUSTOMER(cid, n, addr, ph)) }
-- ============================================================================
SELECT Name 
FROM CUSTOMER;


-- ============================================================================
-- QUERY 2: Orders placed by customer 1
-- RA  : σ Customer_ID = 1 (ORDER_TABLE)
-- TRC : { o | ORDER_TABLE(o) ∧ o.Customer_ID = 1 }
-- DRC : { oid, cid, d, s, a | ORDER_TABLE(oid, cid, d, s, a) ∧ cid = 1 }
-- ============================================================================
SELECT * 
FROM ORDER_TABLE 
WHERE Customer_ID = 1;


-- ============================================================================
-- QUERY 3: Product names in a given order (Order_ID = 401)
-- RA  : π Name (σ Order_ID = 401 (PRODUCT ⨝ CONTAINS))
-- TRC : { p.Name | PRODUCT(p) ∧ ∃c (CONTAINS(c) ∧ c.Product_ID = p.Product_ID ∧ c.Order_ID = 401) }
-- DRC : { n | ∃pid, cat, pr, oid, qty, po (PRODUCT(pid, n, cat, pr) ∧ CONTAINS(oid, pid, qty, po) ∧ oid = 401) }
-- ============================================================================
SELECT p.Name
FROM PRODUCT p
JOIN CONTAINS c ON p.Product_ID = c.Product_ID
WHERE c.Order_ID = 401;


-- ============================================================================
-- QUERY 4: Shipments currently with status "In Transit"
-- RA  : σ Status = 'In Transit' (SHIPS)
-- TRC : { s | SHIPS(s) ∧ s.Status = 'In Transit' }
-- DRC : { sid, wid, oid, dt, loc, st | SHIPS(sid, wid, oid, dt, loc, st) ∧ st = 'In Transit' }
-- ============================================================================
SELECT * 
FROM SHIPS 
WHERE Status = 'In Transit';


-- ============================================================================
-- QUERY 5: Customers who placed at least one order
-- RA  : π Name (CUSTOMER ⨝ ORDER_TABLE)
-- TRC : { c.Name | CUSTOMER(c) ∧ ∃o (ORDER_TABLE(o) ∧ o.Customer_ID = c.Customer_ID) }
-- DRC : { n | ∃cid, addr, ph, oid, d, s, a (CUSTOMER(cid, n, addr, ph) ∧ ORDER_TABLE(oid, cid, d, s, a)) }
-- ============================================================================
SELECT DISTINCT c.Name
FROM CUSTOMER c
JOIN ORDER_TABLE o ON c.Customer_ID = o.Customer_ID;


-- ============================================================================
-- QUERY 6: Current location of each order
-- RA  : π Order_ID, Current_Location (ORDER_TABLE ⨝ SHIPS)
-- TRC : { o.Order_ID, s.Current_Location | ORDER_TABLE(o) ∧ SHIPS(s) ∧ o.Order_ID = s.Order_ID }
-- DRC : { oid, loc | ∃cid, d, st, a, sid, wid, dt, sst (ORDER_TABLE(oid, cid, d, st, a) ∧ SHIPS(sid, wid, oid, dt, loc, sst)) }
-- ============================================================================
SELECT o.Order_ID, s.Current_Location
FROM ORDER_TABLE o
JOIN SHIPS s ON o.Order_ID = s.Order_ID;


-- ============================================================================
-- QUERY 7: Tracking history of a specific shipment (Shipment_ID = 501)
-- RA  : σ Shipment_ID = 501 (TRACKING_UPDATE)
-- TRC : { t | TRACKING_UPDATE(t) ∧ t.Shipment_ID = 501 }
-- DRC : { uid, sid, loc, ts, st | TRACKING_UPDATE(uid, sid, loc, ts, st) ∧ sid = 501 }
-- ============================================================================
SELECT *
FROM TRACKING_UPDATE
WHERE Shipment_ID = 501;

USE warehouse_management;

-- 1. Full Order & Shipment Tracking Summary
SELECT 
    o.Order_ID,
    c.Name AS Buyer_Name,
    p.Name AS Product_Name,
    con.Quantity,
    o.Total_Amount,
    s.Shipment_ID,
    da.Name AS Delivery_Agent,
    tu.Location AS Last_Tracked_Location,
    tu.Status AS Tracking_Status
FROM ORDER_TABLE o
JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID
JOIN CONTAINS con ON o.Order_ID = con.Order_ID
JOIN PRODUCT p ON con.Product_ID = p.Product_ID
JOIN SHIPS s ON o.Order_ID = s.Order_ID
JOIN HANDLES h ON s.Shipment_ID = h.Shipment_ID
JOIN DELIVERY_AGENT da ON h.Agent_ID = da.Agent_ID
JOIN TRACKING_UPDATE tu ON s.Shipment_ID = tu.Shipment_ID
ORDER BY o.Order_ID, tu.Update_ID;

-- 2. Warehouse Inventory Utilization & Valuation
SELECT 
    w.Warehouse_ID,
    w.Location,
    w.Capacity,
    SUM(st.Quantity) AS Current_Stock_Units,
    ROUND((SUM(st.Quantity) / w.Capacity) * 100, 2) AS Utilization_Pct,
    SUM(st.Quantity * p.Price) AS Total_Inventory_Value
FROM WAREHOUSE w
JOIN STORES st ON w.Warehouse_ID = st.Warehouse_ID
JOIN PRODUCT p ON st.Product_ID = p.Product_ID
GROUP BY w.Warehouse_ID, w.Location, w.Capacity;

-- 3. Seller Supply Volume Ranked by Total Units Supplied
SELECT 
    c.Name AS Seller_Name,
    sel.Seller_Type,
    sel.Rating,
    SUM(sup.Quantity) AS Total_Units_Supplied
FROM SELLER sel
JOIN CUSTOMER c ON sel.Customer_ID = c.Customer_ID
JOIN SUPPLIES sup ON sel.Customer_ID = sup.Customer_ID
GROUP BY sel.Customer_ID, c.Name, sel.Seller_Type, sel.Rating
ORDER BY Total_Units_Supplied DESC;

-- 4. Delivery Agent Workload
SELECT 
    da.Agent_ID,
    da.Name,
    COUNT(h.Shipment_ID) AS Assigned_Shipments
FROM DELIVERY_AGENT da
LEFT JOIN HANDLES h ON da.Agent_ID = h.Agent_ID
GROUP BY da.Agent_ID, da.Name;
