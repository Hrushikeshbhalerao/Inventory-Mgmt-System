select * from products;

-----------------------------------------------------------------------------------------------------------------
#Low Stock Alerts

SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity <= reorder_level;
-----------------------------------------------------------------------------------------------------------------------
# Total stock received per product

SELECT
    p.product_id,
    p.product_name,
    SUM(i.quantity) AS total_stock_received
FROM products p
JOIN inventory i
ON p.product_id = i.product_id
WHERE i.transaction_type = 'IN'
GROUP BY p.product_id, p.product_name
ORDER BY total_stock_received DESC;
------------------------------------------------------------------------------------------------------------------------------
# Monthly restocking trends

SELECT
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    COUNT(*) AS restocking_transactions,
    SUM(quantity) AS total_quantity_received
FROM inventory
WHERE transaction_type = 'IN'
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;
---------------------------------------------------------------------------------------------------------------------------------

SELECT product_name, stock_quantity, reorder_level
FROM products
WHERE stock_quantity < reorder_level;