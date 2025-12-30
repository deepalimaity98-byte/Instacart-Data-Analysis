CREATE VIEW customer_kpi AS
SELECT
    user_id,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(days_since_prior_order)) AS avg_reorder_days
FROM orders
GROUP BY user_id;

SELECT * FROM customer_kpi;

-- -----------------------------

CREATE VIEW product_kpi AS
SELECT
    p.product_name,
    p.department,
    COUNT(op.order_id) AS total_orders,
    ROUND(AVG(op.reordered)::numeric, 2) AS reorder_rate
FROM order_products op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_name, p.department;

SELECT * FROM product_kpi;

-- -----------------------------

CREATE VIEW vw_orders_summary AS
SELECT 
	o.order_id,
	o.user_id,
	o.order_number,
	o.order_dow,
	o.order_hour_of_day,
	o.days_since_prior_order,
	COUNT(op.product_id) AS total_items,
	SUM(op.reordered) AS reordered_items
FROM orders o
JOIN order_products op ON o.order_id=op.order_id
GROUP BY 
	o.order_id,
	o.user_id,
	o.order_number,
	o.order_dow,
	o.order_hour_of_day,
	o.days_since_prior_order;
	
SELECT * FROM vw_orders_summary;

SELECT COUNT(order_id) FROM vw_orders_summary;
SELECT SUM(total_items) FROM vw_orders_summary;
SELECT SUM(reordered_items) FROM vw_orders_summary;
SELECT COUNT(DISTINCT user_id) FROM vw_orders_summary;