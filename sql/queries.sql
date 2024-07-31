create database exercicio ;

use exercicio ;
CREATE TABLE CLIENTS (
    id INTEGER PRIMARY KEY auto_increment,
    name varchar(255) NOT NULL,
    email varchar(100) NOT NULL
);
use exercicio ;
CREATE TABLE PRODUCTS (
    id INTEGER PRIMARY KEY auto_increment,
    name varchar(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
CREATE TABLE ORDERS (
    id INTEGER PRIMARY KEY auto_increment,
    client_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total DECIMAL NOT NULL,
    FOREIGN KEY (client_id) REFERENCES CLIENTS(id)
);
use exercicio ;
CREATE TABLE ORDER_ITEMS (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price DECIMAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ORDERS(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(id)
);
INSERT INTO CLIENTS (name, email) VALUES ('Victor', 'Victor9080@Gmail.com');
INSERT INTO CLIENTS (name, email) VALUES ('Wellitin', 'Wellitin36@Gmail.com');

INSERT INTO PRODUCTS (name, price) VALUES ('Porsche', 10.0);
INSERT INTO PRODUCTS (name, price) VALUES ('Uno com escada', 20.0);

INSERT INTO ORDERS (client_id, order_date, total) VALUES (1, '2024-07-30', 30.0);
INSERT INTO ORDERS (client_id, order_date, total) VALUES (2, '2024-07-30', 50.0);

INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, price) VALUES (1, 1, 2, 10.0);
INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, price) VALUES (2, 2, 2, 20.0);

UPDATE PRODUCTS SET price = 15.0 WHERE id = 1;

UPDATE ORDER_ITEMS SET price = 15.0 WHERE product_id = 1;

DELETE FROM ORDER_ITEMS WHERE order_id IN (SELECT id FROM ORDERS WHERE client_id = 1);
DELETE FROM ORDERS WHERE client_id = 1;
DELETE FROM CLIENTS WHERE id = 1;

ALTER TABLE CLIENTS ADD COLUMN birthdate DATE;

SELECT ORDERS.id, CLIENTS.name AS client_name, PRODUCTS.name AS product_name
FROM ORDERS
JOIN CLIENTS ON ORDERS.client_id = CLIENTS.id
JOIN ORDER_ITEMS ON ORDERS.id = ORDER_ITEMS.order_id
JOIN PRODUCTS ON ORDER_ITEMS.product_id = PRODUCTS.id;

SELECT CLIENTS.name AS client_name, ORDERS.id AS order_id
FROM CLIENTS
LEFT JOIN ORDERS ON CLIENTS.id = ORDERS.client_id;

SELECT PRODUCTS.name AS product_name, ORDERS.id AS order_id
FROM PRODUCTS
RIGHT JOIN ORDER_ITEMS ON PRODUCTS.id = ORDER_ITEMS.product_id
RIGHT JOIN ORDERS ON ORDER_ITEMS.order_id = ORDERS.id;

SELECT SUM(total) AS total_sales, SUM(quantity) AS total_items_sold
FROM ORDERS
JOIN ORDER_ITEMS ON ORDERS.id = ORDER_ITEMS.order_id;

SELECT CLIENTS.name, COUNT(ORDERS.id) AS total_orders
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
GROUP BY CLIENTS.name
ORDER BY total_orders DESC;

SELECT PRODUCTS.name, SUM(ORDER_ITEMS.quantity) AS total_quantity_sold
FROM PRODUCTS
JOIN ORDER_ITEMS ON PRODUCTS.id = ORDER_ITEMS.product_id
GROUP BY PRODUCTS.name
ORDER BY total_quantity_sold DESC;

SELECT CLIENTS.name, SUM(ORDERS.total) AS total_spent
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
GROUP BY CLIENTS.name
ORDER BY total_spent DESC;

SELECT PRODUCTS.name, SUM(ORDER_ITEMS.quantity) AS total_quantity_sold, SUM(ORDER_ITEMS.price * ORDER_ITEMS.quantity) AS total_sales
FROM PRODUCTS
JOIN ORDER_ITEMS ON PRODUCTS.id = ORDER_ITEMS.product_id
GROUP BY PRODUCTS.name
ORDER BY total_quantity_sold DESC
LIMIT 3;

SELECT CLIENTS.name, SUM(ORDERS.total) AS total_spent
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
GROUP BY CLIENTS.name
ORDER BY total_spent DESC
LIMIT 3;

SELECT CLIENTS.name, AVG(ORDER_ITEMS.quantity) AS average_quantity_per_order
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
JOIN ORDER_ITEMS ON ORDERS.id = ORDER_ITEMS.order_id
GROUP BY CLIENTS.name;


SELECT strftime('%Y-%m', order_date) AS month, COUNT(DISTINCT ORDERS.id) AS total_orders, COUNT(DISTINCT CLIENTS.id) AS total_clients
FROM ORDERS
JOIN CLIENTS ON ORDERS.client_id = CLIENTS.id
GROUP BY month;

SELECT PRODUCTS.name
FROM PRODUCTS
LEFT JOIN ORDER_ITEMS ON PRODUCTS.id = ORDER_ITEMS.product_id
WHERE ORDER_ITEMS.product_id IS NULL;

SELECT ORDERS.id
FROM ORDERS
JOIN ORDER_ITEMS ON ORDERS.id = ORDER_ITEMS.order_id
GROUP BY ORDERS.id
HAVING COUNT(DISTINCT ORDER_ITEMS.product_id) > 2;

SELECT CLIENTS.name
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
WHERE ORDERS.order_date >= DATE('now', '-1 month');

SELECT CLIENTS.name, AVG(ORDERS.total) AS average_order_value
FROM CLIENTS
JOIN ORDERS ON CLIENTS.id = ORDERS.client_id
GROUP BY CLIENTS.name
ORDER BY average_order_value DESC;


