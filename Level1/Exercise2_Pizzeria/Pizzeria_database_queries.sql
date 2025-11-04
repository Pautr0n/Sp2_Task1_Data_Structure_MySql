-- Exercise 2 Mandatory queries
-- -  List how many products from the 'Beverages' category have been sold in a specific tow
SELECT t.name AS Town, SUM(od.quantity) AS totalBeverages
FROM order_details od
JOIN products p ON od.product_id = p.id
JOIN sales_orders so ON od.sale_order_id = so.sales_order_id
JOIN restaurants r ON so.restaurant_id = r.id
JOIN towns t ON r.towns_id = t.id
WHERE p.type = 'Beverages' AND t.name = 'Irún'
GROUP BY t.name;

-- List how many orders have been delivered by a specific employe
SELECT e.name, e.surname, COUNT(d.sales_order_id) AS Orders
FROM delivery d
JOIN employees e ON d.employee_id = e.employees_id
WHERE e.name = 'Sara' AND e.surname = 'Ortega'
GROUP BY e.name, e.surname;


-- More queries to check database design is working properly
-- towns with its province
SELECT t.name AS town, t.postal_code, p.name AS province
FROM towns t
JOIN provinces p ON t.province_id = p.id;	

-- customers contact information
SELECT c.name, c.surname, c.phone_number, c.address, t.name AS municipio
FROM customers c
JOIN towns t ON c.town_id = t.id; 

-- restaurants'contact information
SELECT r.address AS direccion_restaurante, t.name AS municipio
FROM restaurants r
JOIN towns t ON r.towns_id = t.id;

-- pizza's category
SELECT p.name AS pizza, pc.category_name
FROM products p
JOIN pizzas_has_category phc ON p.id = phc.product_id
JOIN pizza_categories pc ON phc.pizza_category_id = pc.id;

-- order's information
SELECT so.sales_order_id, c.name AS cliente, r.address AS restaurante, so.order_type, so.total_price, so.date
FROM sales_orders so
JOIN customers c ON so.customer_id = c.customers_id
JOIN restaurants r ON so.restaurant_id = r.id;

-- order's details
SELECT od.sale_order_id, p.name AS producto, od.quantity
FROM order_details od
JOIN products p ON od.product_id = p.id;

-- employee information
SELECT e.name, e.surname, e.phone_number, e.dni, e.job_position, r.address AS restaurante
FROM employees e
JOIN restaurants r ON e.restaurant_id = r.id;

-- deliveries by employee
SELECT d.sales_order_id, e.name AS repartidor, e.surname, d.delivered_on
FROM delivery d
JOIN employees e ON d.employee_id = e.employees_id;

-- total orders by type
SELECT order_type, COUNT(*) AS cantidad_pedidos, SUM(total_price) AS total_ingresos
FROM sales_orders
GROUP BY order_type;

-- ABC of products
SELECT p.name AS producto, SUM(od.quantity) AS total_vendido
FROM order_details od
JOIN products p ON od.product_id = p.id
GROUP BY p.name
ORDER BY total_vendido DESC;