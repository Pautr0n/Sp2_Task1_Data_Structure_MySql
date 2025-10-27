use cull_dampolla;

INSERT INTO customers (customers_name, customers_phone, customers_email)
VALUES ('Roberto', '+34665 698 989', 'roberto@roberto.com'),
('Clara', '+36589 000 458', 'clara@clara.com'),
('Toño', '+5526985589', 'tono@tono.com'),
('Gilda', '68533659', 'gilda@gilda.com');

INSERT INTO customers (customers_name, customers_phone, customers_email, customers_reffered_by_customers_id)
VALUES ('Tronaco', '+32658-968-698', 'tronaco@tronaco.com', 1),
('Caballota', '+36589-859-698', 'caballota@caballota.com', 1),
('Coral', '+3469858955', 'coral@coral.com', 3);

INSERT INTO sales_force (sales_force_full_name)
VALUES ('Perico el de los palotes'),('Vendedor Random 2'), ('Vendedor Random 3');


INSERT INTO addresses (addresses_street, addresses_str_number, addresses_dpt_floor, addresses_dpt_number, addresses_postalcode, addresses_city, addresses_country)
VALUES ('Calle falsa','123','2','1','08014','Barcelona','España'),
('Calle falsa','589','8','7','08526','Barcelona','España'),
('Calle falsa','1','96','1','8968','Lleida','España'),
('Calle falsa','123','2','1','75 hbg','Lleida','España'),
('Calle falsa','123','2','1','658 5g6g','Tarragona','España'),
('Calle falsa','123','2','1','555','Paris','Francia'),
('Calle falsa','123','2','1','325-988','Paris','Francia'),
('Calle falsa','123','2','1','66d58d9','Roma','Italia'),
('Calle tron','1258','2','1','08950','Hospitalet de Llobregat','España'),
('Calle addad','32','8','7','08950','Hospitalet de Llobregat','España'),
('Calle gran via','1','96','1','8968','Tarragona','España'),
('Calle falsa','3689','2','1','75 hbg','Tarragona','España');

INSERT INTO customer_has_address VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7);

INSERT INTO suppliers (suppliers_name, suppliers_vat, suppliers_email, suppliers_phone)
VALUES ('Distri Gafas SLU','A66556698','proveedorfalso@falso.com','+34965858985'),
('Gafatronic SA','B56858958','falsoproveedor@falso.com','++366668958989'),
('Manolito Gafota SCP','Z56858987','inventadoproveedor@falso.com','+(698)5585-885-888-888'),
('Glasses not of wine S','X9865875','proveedorinventado@falso.com','+(522)659 66 669 88'),
('Culo Botella SL','R658555478','condemor@falso.com','+3658547896');

INSERT INTO supplier_has_address VALUES (1,8),(2,9),(3,10),(4,11),(5,12);

INSERT INTO glasses_brands (glasses_brands_name, suppliers_suppliers_id)
VALUES ('Police',2),('MO',2),('Prada',1),('Gucci',1),('ChinChin',3),('RayBan',4),('Arnette',4),('Cartier',5),('Chanel',5);

INSERT INTO eyeglasses (glasses_brands_glasses_brands_id, eyeglasses_right_glass_graduation, eyeglasses_left_glass_graduation, 
eyeglasses_frame, eyeglasses_frame_color, eyeglasses_right_glass_color, eyeglasses_left_glass_color, eyeglasses_price)
VALUES (2,1.5,2.0,'METALLIC','Red','Clear','Clear',80.95), (2,4.8,5.0,'PLASTIC','Blue','Smoked','Smoked',99.95),
(3,0.25,0.75,'FLOATING','Silver','Yellow','Yellow',55.95), (1,1.5,2.0,'METALLIC','Purple','Clear','Clear',75.95),
(3,5.5,2.0,'METALLIC','Red','Clear','Clear',75.95), (4,1.5,2.0,'METALLIC','Red','Clear','Clear',65.95),
(5,1.5,2.0,'PLASTIC','Orange','Clear','Clear',20.95), (5,1.85,2.69,'METALLIC','Red','Clear','Clear',35.95);

INSERT INTO sales_orders (customers_customers_id, sales_orders_total_amount, sales_orders_date)
VALUES
(3, 421.75, '2025-01-14'),
(1, 67.20, '2025-02-03'),
(7, 120.50, '2025-03-22'),
(5, 389.99, '2025-04-11'),
(2, 45.00, '2025-05-06'),
(6, 310.25, '2025-06-18'),
(4, 78.90, '2025-07-09'),
(1, 499.99, '2025-08-27'),
(3, 250.00, '2025-09-15'),
(7, 35.00, '2025-10-01'),
(2, 412.10, '2025-11-03'),
(6, 98.75, '2025-12-21'),
(5, 215.40, '2025-03-08'),
(1, 350.00, '2025-06-12'),
(4, 75.25, '2025-09-30'),
(7, 480.00, '2025-11-19'),
(3, 120.00, '2025-02-25'),
(2, 65.00, '2025-04-17'),
(6, 499.00, '2025-07-23'),
(5, 39.99, '2025-10-10'),
(4, 275.60, '2025-01-05');

INSERT INTO order_details (order_details_eyeglasses_id, sales_orders_sales_orders_id, sales_force_sales_force_id) VALUES
(5, 1, 2),
(2, 2, 1),
(7, 3, 3),
(1, 4, 2),
(6, 5, 1),
(3, 6, 3),
(8, 7, 2),
(4, 8, 1),
(2, 9, 3),
(5, 10, 2),
(1, 11, 1),
(7, 12, 3),
(6, 13, 2),
(3, 14, 1),
(8, 15, 3),
(4, 16, 2),
(2, 17, 1),
(5, 18, 3),
(1, 19, 2),
(7, 20, 1),
(6, 21, 3),
(3, 1, 2),
(8, 2, 1),
(4, 3, 3),
(2, 4, 2),
(5, 5, 1),
(1, 6, 3),
(7, 7, 2),
(6, 8, 1),
(3, 9, 3),
(8, 10, 2),
(4, 11, 1),
(2, 12, 3),
(5, 13, 2),
(1, 14, 1),
(7, 15, 3),
(6, 16, 2),
(3, 17, 1),
(8, 18, 3),
(4, 19, 2);

SELECT cst.customers_name, ord.sales_orders_date, ord.sales_orders_id, ord.sales_orders_total_amount FROM sales_orders AS ord
INNER JOIN customers AS cst
ON ord.customers_customers_id = cst.customers_id
WHERE ord.customers_customers_id = 3 AND ord.sales_orders_date BETWEEN '2025-01-01' AND '2025-03-31 23:59:59';

SELECT eg.eyeglasses_id, gb.glasses_brands_name, eg.eyeglasses_frame, eg.eyeglasses_frame_color, sf.sales_force_full_name FROM order_details AS od
JOIN sales_force AS sf ON sf.sales_force_id = od.sales_force_sales_force_id
JOIN eyeglasses AS eg ON eg.eyeglasses_id = od.order_details_eyeglasses_id
JOIN glasses_brands AS gb ON gb.glasses_brands_id = eg.glasses_brands_glasses_brands_id
JOIN sales_orders AS so ON so.sales_orders_id = od.sales_orders_sales_orders_id
WHERE sf.sales_force_id = 1 AND year(so.sales_orders_date) = 2025;

SELECT DISTINCT sp.suppliers_name FROM suppliers AS sp
JOIN glasses_brands AS gb ON gb.suppliers_suppliers_id = sp.suppliers_id
JOIN eyeglasses AS gl ON gl.glasses_brands_glasses_brands_id = gb.glasses_brands_id
JOIN order_details AS od ON od.order_details_eyeglasses_id = gl.eyeglasses_id;




















