use cul_dampolla;

-- Data to populate suppliers' Table
INSERT INTO suppliers (name, vat, phone, email) VALUES
('Ópticas Sol', 'B12345678', '934567890', 'contacto@opticasol.es'),
('Visión Clara', 'B87654321', '933456789', 'info@visionclara.es'),
('Lentes del Norte', 'B11223344', '932345678', 'ventas@lentesnorte.es'),
('Gafas Mediterráneo', 'B99887766', '931234567', 'hola@gafasmediterraneo.es'),
('Óptica Central', 'B55667788', '930123456', 'central@opticacentral.es'),
('Vista Perfecta', 'B66778899', '934567891', 'info@vistaperfecta.es'),
('Lentes Urbanas', 'B77889900', '933456780', 'urbano@lentesurbanas.es'),
('Óptica Express', 'B88990011', '932345670', 'express@opticaexpress.es'),
('Gafas y Más', 'B99001122', '931234560', 'ventas@gafasymas.es'),
('Óptica Barcelona', 'B10111213', '930123450', 'barcelona@opticabcn.es'),
('Lentes del Sur', 'B12131415', '934567892', 'sur@lentesdelsur.es'),
('Óptica Rápida', 'B13141516', '933456781', 'rapida@opticarapida.es'),
('Gafas Total', 'B14151617', '932345671', 'total@gafastotal.es'),
('Óptica Premium', 'B15161718', '931234561', 'premium@opticapremium.es'),
('Lentes Pro', 'B16171819', '930123451', 'pro@lentespro.es'),
('Óptica Global', 'B17181920', '934567893', 'global@opticaglobal.es'),
('Gafas Zoom', 'B18192021', '933456782', 'zoom@gafaszoom.es'),
('Óptica Nova', 'B19202122', '932345672', 'nova@opticanova.es'),
('Lentes Vision', 'B20212223', '931234562', 'vision@lentesvision.es'),
('Óptica Real', 'B21222324', '930123452', 'real@opticareal.es');

-- Data to populate addresses' table
INSERT INTO addresses (street, str_number, floor, door, postalcode, city, country) VALUES
('Calle Mayor', 12, '1º', 2, '08001', 'Barcelona', 'España'),
('Avenida Diagonal', 345, '2º', 1, '08013', 'Barcelona', 'España'),
('Calle Valencia', 78, '3º', 4, '08009', 'Barcelona', 'España'),
('Calle Aragón', 56, 'Bajo', NULL, '08015', 'Barcelona', 'España'),
('Rambla Catalunya', 101, '4º', 3, '08007', 'Barcelona', 'España'),
('Calle Balmes', 200, '5º', 2, '08006', 'Barcelona', 'España'),
('Calle Marina', 33, '6º', 1, '08005', 'Barcelona', 'España'),
('Calle Pau Claris', 88, '7º', 4, '08010', 'Barcelona', 'España'),
('Calle Casanova', 150, '8º', 3, '08011', 'Barcelona', 'España'),
('Calle Urgell', 45, '9º', 2, '08008', 'Barcelona', 'España'),
('Calle Sants', 67, '1º', 1, '08014', 'Barcelona', 'España'),
('Calle Numancia', 89, '2º', 2, '08029', 'Barcelona', 'España'),
('Calle Entença', 123, '3º', 3, '08015', 'Barcelona', 'España'),
('Calle Londres', 34, '4º', 4, '08036', 'Barcelona', 'España'),
('Calle Berlín', 56, '5º', 1, '08029', 'Barcelona', 'España'),
('Calle París', 78, '6º', 2, '08029', 'Barcelona', 'España'),
('Calle Roma', 90, '7º', 3, '08029', 'Barcelona', 'España'),
('Calle Milán', 102, '8º', 4, '08029', 'Barcelona', 'España'),
('Calle Nápoles', 114, '9º', 1, '08029', 'Barcelona', 'España'),
('Calle Sicilia', 126, '10º', 2, '08029', 'Barcelona', 'España');

-- Data to populate supplier_has_address relation
INSERT INTO supplier_has_address (suppliers_id, addresses_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20);

-- Including 20 new addresses for customers:
INSERT INTO addresses (street, str_number, floor, door, postalcode, city, country) VALUES
('Calle Lepanto', 23, '1º', 1, '08013', 'Barcelona', 'España'),
('Calle Mallorca', 45, '2º', 2, '08014', 'Barcelona', 'España'),
('Calle Provenza', 67, '3º', 3, '08015', 'Barcelona', 'España'),
('Calle Roger de Llúria', 89, '4º', 4, '08009', 'Barcelona', 'España'),
('Calle Bruc', 101, '5º', 1, '08010', 'Barcelona', 'España'),
('Calle Diputació', 123, '6º', 2, '08011', 'Barcelona', 'España'),
('Calle Gran Vía', 145, '7º', 3, '08012', 'Barcelona', 'España'),
('Calle Trafalgar', 167, '8º', 4, '08013', 'Barcelona', 'España'),
('Calle Ausiàs March', 189, '9º', 1, '08014', 'Barcelona', 'España'),
('Calle Girona', 201, '10º', 2, '08015', 'Barcelona', 'España'),
('Calle Ali Bei', 222, '1º', 3, '08001', 'Barcelona', 'España'),
('Calle Marina Alta', 244, '2º', 4, '08002', 'Barcelona', 'España'),
('Calle Escorial', 266, '3º', 1, '08003', 'Barcelona', 'España'),
('Calle Pi i Margall', 288, '4º', 2, '08004', 'Barcelona', 'España'),
('Calle Sant Antoni Maria Claret', 310, '5º', 3, '08005', 'Barcelona', 'España'),
('Calle Indústria', 332, '6º', 4, '08006', 'Barcelona', 'España'),
('Calle Encarnació', 354, '7º', 1, '08007', 'Barcelona', 'España'),
('Calle Torrent de lOlla', 376, '8º', 2, '08008', 'Barcelona', 'España'),
('Calle Verdi', 398, '9º', 3, '08009', 'Barcelona', 'España'),
('Calle Astúries', 420, '10º', 4, '08010', 'Barcelona', 'España');

-- Data to populate customers' table
INSERT INTO customers (name, phone, email, reffered_by) VALUES
('Laura Martínez', '600123456', 'laura.martinez@email.com', NULL),
('Carlos Gómez', '600234567', 'carlos.gomez@email.com', 1),
('Ana Torres', '600345678', 'ana.torres@email.com', 2),
('Javier Ruiz', '600456789', 'javier.ruiz@email.com', NULL),
('Marta Sánchez', '600567890', 'marta.sanchez@email.com', 1),
('Luis Fernández', '600678901', 'luis.fernandez@email.com', 3),
('Elena Navarro', '600789012', 'elena.navarro@email.com', NULL),
('Pedro López', '600890123', 'pedro.lopez@email.com', 4),
('Sara Ortega', '600901234', 'sara.ortega@email.com', 5),
('David Molina', '600012345', 'david.molina@email.com', NULL),
('Isabel Romero', '600111222', 'isabel.romero@email.com', 6),
('Miguel Castro', '600222333', 'miguel.castro@email.com', NULL),
('Patricia León', '600333444', 'patricia.leon@email.com', 7),
('Raúl Ibáñez', '600444555', 'raul.ibanez@email.com', NULL),
('Lucía Domínguez', '600555666', 'lucia.dominguez@email.com', 8),
('Alberto Gil', '600666777', 'alberto.gil@email.com', NULL),
('Cristina Vega', '600777888', 'cristina.vega@email.com', 9),
('Sergio Ramos', '600888999', 'sergio.ramos@email.com', NULL),
('Natalia Paredes', '600999000', 'natalia.paredes@email.com', 10),
('Andrés Cordero', '600000111', 'andres.cordero@email.com', NULL);

-- Data to populate customer_has_address relation
INSERT INTO customer_has_address (customers_id, addresses_id) VALUES
(1, 21), (2, 22), (3, 23), (4, 24), (5, 25),
(6, 26), (7, 27), (8, 28), (9, 29), (10, 30),
(11, 31), (12, 32), (13, 33), (14, 34), (15, 35),
(16, 36), (17, 37), (18, 38), (19, 39), (20, 40);

-- Data to populate employees¡ table
INSERT INTO employee (full_name) VALUES
('María Hernández'),
('José Martínez'),
('Laura Pérez'),
('Antonio García');

-- Data to populate eyeglasses' table
INSERT INTO eyeglasses (suppliers_id, glasses_brands_glasses_brands_id, right_glass_graduation, left_glass_graduation, frame_type, frame_color, right_glass_color, left_glass_color, price, brand) VALUES
(1, 1, 1.25, 1.00, 'PLASTIC', 'Negro', 'Transparente', 'Transparente', 89.99, 'Rayban'),
(2, 2, 2.00, 1.75, 'METALLIC', 'Plateado', 'Azul', 'Azul', 120.50, 'Oakley'),
(3, 3, 0.75, 0.50, 'FLOATING', 'Transparente', 'Verde', 'Verde', 95.00, 'Vogue'),
(4, 4, 1.50, 1.25, 'PLASTIC', 'Rojo', 'Gris', 'Gris', 110.00, 'Gucci'),
(5, 5, 2.25, 2.00, 'METALLIC', 'Dorado', 'Marrón', 'Marrón', 135.75, 'Prada'),
(6, 6, 1.00, 0.75, 'FLOATING', 'Azul', 'Negro', 'Negro', 99.99, 'Versace'),
(7, 7, 1.75, 1.50, 'PLASTIC', 'Verde', 'Rosa', 'Rosa', 105.00, 'Tom Ford'),
(8, 8, 2.50, 2.25, 'METALLIC', 'Negro', 'Amarillo', 'Amarillo', 140.00, 'Armani'),
(9, 9, 0.50, 0.25, 'FLOATING', 'Blanco', 'Transparente', 'Transparente', 85.00, 'Chanel'),
(10, 10, 1.25, 1.00, 'PLASTIC', 'Gris', 'Azul', 'Azul', 115.00, 'Rayban'),
(11, 11, 2.00, 1.75, 'METALLIC', 'Rojo', 'Verde', 'Verde', 130.00, 'Oakley'),
(12, 12, 0.75, 0.50, 'FLOATING', 'Dorado', 'Gris', 'Gris', 90.00, 'Vogue'),
(13, 13, 1.50, 1.25, 'PLASTIC', 'Azul', 'Marrón', 'Marrón', 125.00, 'Gucci'),
(14, 14, 2.25, 2.00, 'METALLIC', 'Verde', 'Negro', 'Negro', 145.00, 'Prada'),
(15, 15, 1.00, 0.75, 'FLOATING', 'Negro', 'Rosa', 'Rosa', 100.00, 'Versace'),
(16, 16, 1.75, 1.50, 'PLASTIC', 'Blanco', 'Amarillo', 'Amarillo', 110.00, 'Tom Ford'),
(17, 17, 2.50, 2.25, 'METALLIC', 'Gris', 'Transparente', 'Transparente', 150.00, 'Armani'),
(18, 18, 0.50, 0.25, 'FLOATING', 'Rojo', 'Azul', 'Azul', 95.00, 'Chanel'),
(19, 19, 1.25, 1.00, 'PLASTIC', 'Dorado', 'Verde', 'Verde', 120.00, 'Rayban'),
(20, 20, 2.00, 1.75, 'METALLIC', 'Azul', 'Gris', 'Gris', 135.00, 'Oakley');

-- Data to populate sales_orders' table
INSERT INTO sales_orders (customers_id, total_amount) VALUES
(1, 89.99), (2, 120.50), (3, 95.00), (4, 110.00), (5, 135.75),
(6, 99.99), (7, 105.00), (8, 140.00), (9, 85.00), (10, 115.00),
(11, 130.00), (12, 90.00), (13, 125.00), (14, 145.00), (15, 100.00),
(16, 110.00), (17, 150.00), (18, 95.00), (19, 120.00), (20, 135.00);

-- Data to populate order_details table
INSERT INTO order_details (eyeglasses_id, sales_orders_id, employee_id) VALUES
(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 1),
(6, 6, 2), (7, 7, 3), (8, 8, 4), (9, 9, 1), (10, 10, 2),
(11, 11, 3), (12, 12, 4), (13, 13, 1), (14, 14, 2), (15, 15, 3),
(16, 16, 4), (17, 17, 1), (18, 18, 2), (19, 19, 3), (20, 20, 4);