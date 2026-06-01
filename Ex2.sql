-- Tạo schema
CREATE SCHEMA schema3;

-- =========================
-- Tạo bảng products
-- =========================
CREATE TABLE schema3.products (
                                  product_id SERIAL PRIMARY KEY,
                                  product_name VARCHAR(100),
                                  category VARCHAR(50)
);

-- =========================
-- Tạo bảng orders
-- =========================
CREATE TABLE schema3.orders (
                                order_id SERIAL PRIMARY KEY,
                                product_id INT,
                                quantity INT,
                                total_price NUMERIC(10,2),

                                CONSTRAINT fk_product
                                    FOREIGN KEY (product_id)
                                        REFERENCES schema3.products(product_id)
);

-- =========================
-- Insert dữ liệu vào products
-- =========================
INSERT INTO schema3.products (product_id, product_name, category)
VALUES
    (1, 'Laptop Dell', 'Electronics'),
    (2, 'IPhone 15', 'Electronics'),
    (3, 'Bàn học gỗ', 'Furniture'),
    (4, 'Ghế xoay', 'Furniture');

-- =========================
-- Insert dữ liệu vào orders
-- =========================
INSERT INTO schema3.orders (order_id, product_id, quantity, total_price)
VALUES
    (101, 1, 2, 2200),
    (102, 2, 3, 3300),
    (103, 3, 5, 2500),
    (104, 4, 4, 1600),
    (105, 1, 1, 1100);

-- =========================
-- Kiểm tra dữ liệu
-- =========================
SELECT * FROM schema3.products;
SELECT * FROM schema3.orders;

/*
SELECT p.category, sum(o.quantity) quantity, sum(o.total_price) total_price from schema3.products p
INNER JOIN schema3.orders o on p.product_id = o.product_id
GROUP BY p.category
HAVING sum(o.total_price) > 2000
ORDER BY total_price DESC;
*/

SELECT p.product_name,sum(o.total_price) total_price from schema3.products p
INNER JOIN schema3.orders o on p.product_id = o.product_id
GROUP BY p.product_id
HAVING sum(o.total_price) = (SELECT sum(total_price) as total_revenue FROM schema3.orders o
                             GROUP BY o.product_id
                             ORDER BY total_revenue DESC
                             LIMIT 1);

