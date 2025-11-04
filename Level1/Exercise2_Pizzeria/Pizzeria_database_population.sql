INSERT INTO provinces (name) VALUES
('Barcelona'), ('Madrid'), ('Valencia'), ('Sevilla'), ('Zaragoza'),
('Málaga'), ('Murcia'), ('Palma'), ('Las Palmas'), ('Bilbao'),
('Alicante'), ('Córdoba'), ('Valladolid'), ('Vigo'), ('Gijón'),
('Granada'), ('Tarragona'), ('Santander'), ('Almería'), ('San Sebastián');

INSERT INTO towns (name, postal_code, province_id) VALUES
('L\'Hospitalet de Llobregat', '08901', 1),
('Móstoles', '28931', 2),
('Torrent', '46900', 3),
('Dos Hermanas', '41701', 4),
('Utebo', '50180', 5),
('Marbella', '29601', 6),
('Cartagena', '30201', 7),
('Inca', '07300', 8),
('Telde', '35200', 9),
('Barakaldo', '48901', 10),
('Elche', '03201', 11),
('Lucena', '14900', 12),
('Laguna de Duero', '47140', 13),
('Redondela', '36800', 14),
('Avilés', '33401', 15),
('Motril', '18600', 16),
('Reus', '43201', 17),
('Torrelavega', '39300', 18),
('Roquetas de Mar', '04740', 19),
('Irún', '20300', 20);

INSERT INTO customers (town_id, name, surname, phone_number, address) VALUES
(1, 'Carlos', 'Martínez', '600111222', 'Calle Mayor 12'),
(2, 'Laura', 'Gómez', '600222333', 'Avenida del Sol 45'),
(3, 'Javier', 'López', '600333444', 'Calle Luna 78'),
(4, 'Marta', 'Ruiz', '600444555', 'Paseo del Río 56'),
(5, 'Luis', 'Sánchez', '600555666', 'Calle Jardín 101'),
(6, 'Elena', 'Torres', '600666777', 'Calle Mar 200'),
(7, 'Pedro', 'Navarro', '600777888', 'Calle Norte 33'),
(8, 'Sara', 'Ortega', '600888999', 'Calle Sur 88'),
(9, 'David', 'Molina', '600999000', 'Calle Este 150'),
(10, 'Isabel', 'Romero', '600000111', 'Calle Oeste 45'),
(11, 'Miguel', 'Castro', '600123456', 'Calle Centro 67'),
(12, 'Patricia', 'León', '600234567', 'Calle Nueva 89'),
(13, 'Raúl', 'Ibáñez', '600345678', 'Calle Vieja 123'),
(14, 'Lucía', 'Domínguez', '600456789', 'Calle Alta 34'),
(15, 'Alberto', 'Gil', '600567890', 'Calle Baja 56'),
(16, 'Cristina', 'Vega', '600678901', 'Calle Real 78'),
(17, 'Sergio', 'Ramos', '600789012', 'Calle Falsa 90'),
(18, 'Natalia', 'Paredes', '600890123', 'Calle Larga 102'),
(19, 'Andrés', 'Cordero', '600901234', 'Calle Ancha 114'),
(20, 'Clara', 'Reyes', '600012345', 'Calle Peatonal 126');

INSERT INTO restaurants (address, towns_id) VALUES
('Calle Italia 10', 1),
('Avenida Roma 22', 5),
('Calle París 33', 10),
('Calle Berlín 44', 15),
('Calle Londres 55', 20);

INSERT INTO pizza_categories (category_name) VALUES
('Clásicas'),
('Especiales'),
('Vegetarianas'),
('Picantes'),
('Infantiles');

INSERT INTO products (name, description, price, type) VALUES
('Margarita', 'Tomate, mozzarella y albahaca', 7.50, 'Pizza'),
('Pepperoni', 'Tomate, mozzarella y pepperoni', 8.50, 'Pizza'),
('Cuatro Quesos', 'Mozzarella, gorgonzola, parmesano y emmental', 9.00, 'Pizza'),
('Barbacoa', 'Carne, cebolla y salsa barbacoa', 9.50, 'Pizza'),
('Vegetal', 'Verduras frescas y mozzarella', 8.00, 'Pizza'),
('Mexicana', 'Jalapeños, carne picada y cebolla', 9.50, 'Pizza'),
('Infantil', 'Pizza pequeña con jamón y queso', 6.00, 'Pizza'),
('Hawaiana', 'Piña, jamón y mozzarella', 8.50, 'Pizza'),
('Carbonara', 'Bacon, cebolla y salsa carbonara', 9.00, 'Pizza'),
('Del Chef', 'Ingredientes seleccionados por el chef', 10.00, 'Pizza'),
('Hamburguesa Clásica', 'Carne, lechuga, tomate y queso', 7.00, 'Hamburguer'),
('Hamburguesa BBQ', 'Carne, bacon, cebolla y salsa BBQ', 8.00, 'Hamburguer'),
('Hamburguesa Vegana', 'Hamburguesa vegetal con verduras', 7.50, 'Hamburguer'),
('Coca-Cola', 'Refresco de cola 33cl', 2.00, 'Beverages'),
('Agua Mineral', 'Botella de agua 50cl', 1.50, 'Beverages'),
('Cerveza', 'Cerveza artesanal 33cl', 2.50, 'Beverages'),
('Fanta Naranja', 'Refresco de naranja 33cl', 2.00, 'Beverages'),
('Nestea', 'Té frío con limón 33cl', 2.00, 'Beverages'),
('Sprite', 'Refresco de lima-limón 33cl', 2.00, 'Beverages'),
('Zumo de Piña', 'Zumo natural de piña 33cl', 2.50, 'Beverages');

INSERT INTO pizzas_has_category (product_id, pizza_category_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 2), (5, 3),
(6, 4), (7, 5), (8, 1), (9, 2), (10, 2);

INSERT INTO sales_orders (restaurant_id, customer_id, order_type, total_price) VALUES
(1, 1, 'Delivery', 15.00), (2, 2, 'Restaurant', 20.00), (3, 3, 'Delivery', 12.50),
(4, 4, 'Restaurant', 18.00), (5, 5, 'Delivery', 22.00), (1, 6, 'Restaurant', 19.50),
(2, 7, 'Delivery', 16.00), (3, 8, 'Restaurant', 21.00), (4, 9, 'Delivery', 13.50),
(5, 10, 'Restaurant', 17.00), (1, 11, 'Delivery', 14.00), (2, 12, 'Restaurant', 20.50),
(3, 13, 'Delivery', 15.50), (4, 14, 'Restaurant', 18.50), (5, 15, 'Delivery', 22.50),
(1, 16, 'Restaurant', 19.00), (2, 17, 'Delivery', 16.50), (3, 18, 'Restaurant', 21.50),
(4, 19, 'Delivery', 13.00), (5, 20, 'Restaurant', 17.50);

INSERT INTO order_details (sale_order_id, product_id, quantity) VALUES
(1, 1, 1), (1, 14, 2), (2, 2, 2), (2, 15, 1),
(3, 3, 1), (3, 16, 1), (4, 4, 2), (4, 17, 1),
(5, 5, 1), (5, 18, 2), (6, 6, 2), (6, 19, 1),
(7, 7, 1), (7, 20, 2), (8, 8, 2), (8, 13, 1),
(9, 9, 1), (9, 12, 1), (10, 10, 2), (10, 11, 1);

INSERT INTO employees (restaurant_id, name, surname, phone_number, dni, job_position) VALUES
(1, 'Mario', 'Serrano', '611111111', '12345678A', 'Kitchen'),
(1, 'Lucía', 'García', '611111112', '12345679B', 'Delivery'),
(2, 'Carlos', 'López', '611111113', '12345680C', 'Kitchen'),
(2, 'Ana', 'Martínez', '611111114', '12345681D', 'Delivery'),
(3, 'David', 'Fernández', '611111115', '12345682E', 'Kitchen'),
(3, 'Elena', 'Torres', '611111116', '12345683F', 'Delivery'),
(4, 'Javier', 'Ruiz', '611111117', '12345684G', 'Kitchen'),
(4, 'Marta', 'Sánchez', '611111118', '12345685H', 'Delivery'),
(5, 'Luis', 'Navarro', '611111119', '12345686I', 'Kitchen'),
(5, 'Sara', 'Ortega', '611111120', '12345687J', 'Delivery');

INSERT INTO delivery (sales_order_id, employee_id) VALUES
(1, 2), (3, 4), (5, 6), (7, 8), (9, 10),
(11, 2), (13, 4), (15, 6), (17, 8), (19, 10);

