# DBMS-Warehouse-Management-system
Relational database management system for warehouse inventory, supplier tracking, and automated order fulfillment built with SQL.

# Warehouse Management System (DBMS)

A relational database solution designed to streamline warehouse inventory tracking, supplier coordination, and order fulfillment. Built using **[MySQL / PostgreSQL / SQLite]** (and **[Python / Java / PHP]** if applicable), this project enforces data integrity through a normalized schema and automates stock updates.

## Key Features
* **Normalized Schema (3NF):** Eliminates data redundancy across products, categories, suppliers, warehouses, and customer orders.
* **Automated Inventory Control:** Uses SQL triggers to automatically deduct stock levels upon order placement and flag low-inventory items.
* **Role-Based Access / Views:** Pre-built SQL views for warehouse managers to monitor daily shipments, pending restocks, and supplier performance.
* **Analytical Reporting:** Complex multi-table join queries to track fast-moving goods, order fulfillment rates, and valuation metrics.

## Database Architecture
*(Tip: Upload your ER diagram image to a `docs/` folder and link it below)*
![Entity Relationship Diagram](docs/er-diagram.png)

## Tech Stack
* **Database:** [e.g., MySQL 8.0 / PostgreSQL]
* **Tools:** [e.g., MySQL Workbench, pgAdmin, DBeaver]
* **Application Layer:** [e.g., Python / CLI / None - Pure SQL]
