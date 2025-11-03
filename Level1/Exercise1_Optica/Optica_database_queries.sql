-- Queries to test database
-- Suppliers' addresses
SELECT s.name, s.vat, a.street, a.str_number, a.floor, a.door, a.postalcode,  a.city, a.country
FROM suppliers s
JOIN supplier_has_address sha ON s.suppliers_id = sha.suppliers_id
JOIN addresses a ON sha.addresses_id = a.addresses_id;

-- Orders information
SELECT so.sales_orders_id, c.name AS cliente, e.full_name AS empleado, so.total_amount, so.date
FROM sales_orders so
JOIN customers c ON so.customers_id = c.customers_id
JOIN order_details od ON so.sales_orders_id = od.sales_orders_id
JOIN employee e ON od.employee_id = e.employee_id;

-- Eyeglasses sold with details
SELECT eg.eyeglasses_id, eg.brand, eg.frame_type, eg.left_glass_graduation, eg.right_glass_graduation, eg.price, s.name AS proveedor
FROM eyeglasses eg
JOIN suppliers s ON eg.suppliers_id = s.suppliers_id
JOIN order_details od ON eg.eyeglasses_id = od.eyeglasses_id;

-- Customers that has been reffered 
SELECT c1.name AS cliente, c2.name AS referido_por
FROM customers c1
JOIN customers c2 ON c1.reffered_by = c2.customers_id;

-- Total sales by employee
SELECT e.full_name, SUM(so.total_amount) AS total_vendido
FROM employee e
JOIN order_details od ON e.employee_id = od.employee_id
JOIN sales_orders so ON od.sales_orders_id = so.sales_orders_id
GROUP BY e.full_name;

-- Eyeglasses sold by brand
SELECT brand, COUNT(*) AS cantidad_vendida
FROM eyeglasses eg
JOIN order_details od ON eg.eyeglasses_id = od.eyeglasses_id
GROUP BY brand
ORDER BY cantidad_vendida DESC;

-- Total orders from last month
SELECT sales_orders_id, total_amount, date
FROM sales_orders
WHERE date >= DATE_SUB(NOW(), INTERVAL 1 MONTH);