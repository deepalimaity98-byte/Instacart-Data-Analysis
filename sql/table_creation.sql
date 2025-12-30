CREATE TABLE order_products(
	order_id INT ,
	product_id INT ,
	add_to_cart_order INT,
	reordered INT
);
SELECT * FROM order_products;


CREATE TABLE orders(
	order_id INT,
	user_id INT,
	eval_set VARCHAR(50),
	order_number INT,
	order_dow INT,
	order_hour_of_day INT,
	days_since_prior_order FLOAT
);
SELECT * FROM orders;

CREATE TABLE products(
	product_id INT,
	product_name VARCHAR(400),
	aisle_id INT,
	department_id INT,
	aisle VARCHAR(300),
	department VARCHAR(200)
);
SELECT * FROM products;