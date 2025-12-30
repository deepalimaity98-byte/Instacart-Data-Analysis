SELECT DISTINCT order_id,COUNT(*) FROM order_products
GROUP BY order_id;

-- CUSTOMER BEHAVIOR ANALYSIS
-- New vs Returning Customers
SELECT 
	CASE
		WHEN max_orders>= 2 THEN 'Returned Customer'
		ELSE 'New Customer'
	END AS customer_type,
	COUNT(DISTINCT user_id) AS total_users
FROM(
	SELECT user_id, MAX(order_number) AS max_orders
	FROM orders GROUP BY user_id
) AS user_counts
GROUP BY 1;

-- CUSTOMER ORDER FREQUENCY DISTRIBUTION
SELECT order_number,COUNT(user_id) FROM orders
GROUP BY order_number
ORDER BY order_number;

-- Reorder rate by product
SELECT p.product_name,ROUND(AVG(op.reordered)::numeric,2) AS reorder_rate FROM order_products op
JOIN products p ON p.product_id=op.product_id
GROUP BY p.product_name
ORDER BY reorder_rate DESC LIMIT 50;

-- Reorder rate by department
SELECT p.department,ROUND(AVG(op.reordered)::numeric,2) AS reorder_rate
	FROM order_products op
	JOIN  products p ON p.product_id=op.product_id
GROUP BY p.department
ORDER BY reorder_rate DESC LIMIT 50;

-- customers buy per order
SELECT ROUND(AVG(item_count),2) AS avg_items_per_order 
FROM (
SELECT order_id,COUNT(*) AS item_count FROM order_products
GROUP BY order_id
);


-- Average Basket Size
SELECT ROUND(AVG(product_count),2) AS avg_basket_size
FROM (
    SELECT order_id, COUNT(product_id) AS product_count
    FROM order_products
    GROUP BY order_id
);

-- Basket Size by Day of Week
SELECT o.order_dow,
		ROUND(AVG(items),2)	AS avg_items
FROM orders o
JOIN(
SELECT order_id,COUNT(*) AS items 
FROM order_products
GROUP BY order_id
) op ON o.order_id= op.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;


-- TIME & BEHAVIOR PATTERNS
-- Peak order hours
SELECT order_hour_of_day,COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders DESC;

-- Average days between orders
SELECT ROUND(AVG(days_since_prior_order)) AS avg_days_between_orders
FROM orders;


-- Days since prior order pattern
SELECT days_since_prior_order,
		COUNT(*) AS orders
FROM orders
WHERE days_since_prior_order IS NOT NULL
GROUP BY days_since_prior_order
ORDER BY days_since_prior_order

-- Reorder trend by hour
SELECT o.order_hour_of_day,
		COUNT(reordered) AS reorder_item
FROM order_products op
JOIN orders o ON op.order_id= o.order_id
GROUP BY o.order_hour_of_day
ORDER BY o.order_hour_of_day;

-- Top reordered products
SELECT p.product_name, COUNT(*) AS reorder_count
FROM order_products op
JOIN products p ON op.product_id = p.product_id
WHERE reordered >= 1
GROUP BY p.product_name
ORDER BY reorder_count DESC
LIMIT 10;

-- Department-wise Reorder Rate
SELECT 
    p.department,
    ROUND(SUM(op.reordered)*100.0 / COUNT(*),2) AS reorder_rate
FROM order_products op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.department
ORDER BY reorder_rate DESC;

-- ----------------------------












	
		
