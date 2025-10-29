USE pizzeria;

INSERT INTO provinces (provinces_name) 
VALUES ('Barcelona'), ('Girona'), ('Tarragona');

INSERT INTO towns (towns_name, towns_postal_code, provinces_provinces_id) 
VALUES ('Barcelona', '08001', 1), ('Badalona', '08911', 1),('Girona', '17001', 2),
  ('Figueres', '17600', 2), ('Tarragona', '43001', 3),('Reus', '43201', 3);
  
INSERT INTO customers (towns_towns_id, customers_name, customers_surname, customers_address) 
VALUES (1, 'Laura', 'Gómez', 'Carrer de la Pau 12'),
  (2, 'Carlos', 'Martínez', 'Av. Mediterrani 45'),
  (3, 'Marta', 'Ribas', 'Carrer Girona 88'),
  (4, 'Joan', 'Serra', 'Carrer Nou 5'),
  (5, 'Anna', 'Vila', 'Rambla Nova 21'),
  (6, 'Pere', 'Ferrer', 'Carrer Sant Joan 33');

INSERT INTO phones (phones_number) 
VALUES ('+34 600123456'), ('+34 600654321'), ('+34 600987654'), ('+34 600111222'), ('+34 600333444'), ('+34 600555666');

INSERT INTO customer_has_phone (phones_phones_id, customers_customers_id) 
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);
  
INSERT INTO restaurants (restaurants_address, towns_towns_id) 
VALUES ('Carrer Gran 1', 1),
  ('Av. Mar 22', 3),
  ('Passeig Central 9', 5);
  
INSERT INTO pizza_categories (pizza_categories_name) 
VALUES ('Clásica'), ('Vegetariana'), ('Picante');

INSERT INTO products (products_name, products_description, products_price, products_type) 
VALUES ('Margarita', 'Tomate, mozzarella, albahaca', 8.50, 'Pizza'),
  ('Pepperoni', 'Tomate, mozzarella, pepperoni', 9.00, 'Pizza'),
  ('Veggie', 'Verduras variadas, mozzarella', 9.50, 'Pizza'),
  ('Hamburguesa BBQ', 'Carne, queso, salsa BBQ', 7.50, 'Hamburguer'),
  ('Coca-Cola', 'Refresco 33cl', 2.00, 'Beverages'),
  ('Agua mineral', 'Botella 50cl', 1.50, 'Beverages');

INSERT INTO pizzas_has_category (products_products_id, pizza_categories_pizza_categories_id) 
VALUES (1, 1), (2, 3), (3, 2);
  
INSERT INTO sales_orders (restaurants_restaurants_id, customers_customers_id, sales_orders_type, sales_orders_total_price) 
VALUES (1, 1, 'Delivery', 19.00),
  (2, 3, 'Restaurant', 11.50),
  (3, 5, 'Delivery', 10.50),
  (1, 2, 'Restaurant', 9.00);

INSERT INTO order_details (sales_orders_sales_orders_id, products_products_id, order_details_quantity) 
VALUES (1, 2, 1), (1, 5, 2),
  (2, 3, 1), (2, 6, 1),
  (3, 1, 1), (3, 4, 1),
  (4, 2, 1);
  
INSERT INTO employees (restaurants_restaurants_id, employees_name, employees_surname, employees_DNI, employees_job_position, delivery_sales_orders_sales_orders_id, delivery_sales_orders_customers_customers_id) VALUES 
  (1, 'Sergi', 'López', '12345678A', 'Delivery', 1, 1),
  (2, 'Núria', 'Pons', '23456789B', 'Kitchen', 2, 3),
  (3, 'David', 'Roig', '34567890C', 'Delivery', 3, 5),
  (1, 'Clara', 'Solé', '45678901D', 'Kitchen', 4, 2);

INSERT INTO phones (phones_number) 
VALUES ('+34 600777888'), ('+34 600999000');

INSERT INTO employee_has_phone (employees_employees_id, phones_phones_id) 
VALUES (1, 7), (3, 8);

INSERT INTO delivery (sales_orders_sales_orders_id, employees_employees_id) 
VALUES (1, 1), (3, 3);

SELECT t.towns_name AS Town,
  SUM(od.order_details_quantity) AS Beverages_sold
FROM order_details od
JOIN products p ON od.products_products_id = p.products_id
JOIN sales_orders so ON od.sales_orders_sales_orders_id = so.sales_orders_id
JOIN restaurants r ON so.restaurants_restaurants_id = r.restaurants_id
JOIN towns t ON r.towns_towns_id = t.towns_id
WHERE p.products_type = 'Beverages' AND t.towns_name = 'Barcelona'
GROUP BY t.towns_name;

SELECT e.employees_name AS Name,
e.employees_surname AS Surname,
COUNT(d.sales_orders_sales_orders_id) AS OrdersDelivered
FROM employees e
JOIN delivery d ON e.employees_id = d.employees_employees_id
WHERE e.employees_name = 'Sergi' AND e.employees_surname = 'López'
GROUP BY e.employees_id;


