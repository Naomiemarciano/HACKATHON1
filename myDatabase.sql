-- -- CREATE TABLE for Users
-- CREATE TABLE users (
--     id SERIAL PRIMARY KEY,
--     username VARCHAR(50) UNIQUE NOT NULL,
--     email VARCHAR(100) UNIQUE NOT NULL,
--     password TEXT NOT NULL
-- );

-- -- CREATE TABLE for Categories
-- CREATE TABLE categories (
--     categorie_id SERIAL PRIMARY KEY,
--     categorie_name VARCHAR(50) UNIQUE NOT NULL
-- );

-- -- CREATE TABLE for Product Types
-- CREATE TABLE types_of_product (
--     type_id SERIAL PRIMARY KEY,
--     type_name VARCHAR(50) UNIQUE NOT NULL
-- );

-- -- CREATE TABLE for Colors
-- CREATE TABLE colors (
--     color_id SERIAL PRIMARY KEY,
--     color VARCHAR(30) UNIQUE NOT NULL
-- );

-- -- CREATE TABLE for Sizes
-- CREATE TABLE sizes (
--     size_id SERIAL PRIMARY KEY,
--     size_name VARCHAR(10) UNIQUE NOT NULL
-- );

-- -- CREATE TABLE for Products (My Store)
-- CREATE TABLE my_store (
--     article_id SERIAL PRIMARY KEY,
--     name_of_article VARCHAR(100) NOT NULL,
--     price DECIMAL(10,2) NOT NULL,
--     stock INT NOT NULL,
--     color_id INT REFERENCES colors(color_id),
--     size_id INT REFERENCES sizes(size_id)
-- );

-- -- CREATE TABLE for Product Categories
-- CREATE TABLE product_categories (
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     category_id INT REFERENCES categories(categorie_id) ON DELETE CASCADE,
--     PRIMARY KEY (product_id, category_id)
-- );

-- -- CREATE TABLE for Product Types
-- CREATE TABLE product_types (
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     type_id INT REFERENCES types_of_product(type_id) ON DELETE CASCADE,
--     PRIMARY KEY (product_id, type_id)
-- );

-- -- CREATE TABLE for Cart (Shopping Cart)
-- CREATE TABLE cart (
--     cart_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(id) ON DELETE CASCADE,
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     quantity INT NOT NULL CHECK (quantity > 0)
-- );

-- -- CREATE TABLE for Orders
-- CREATE TABLE orders (
--     order_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(id) ON DELETE CASCADE,
--     total_price DECIMAL(10,2) NOT NULL,
--     order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- -- CREATE TABLE for Order Items
-- CREATE TABLE order_items (
--     order_item_id SERIAL PRIMARY KEY,
--     order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     quantity INT NOT NULL CHECK (quantity > 0),
--     price DECIMAL(10,2) NOT NULL
-- );

-- -- INSERT INTO users (username, email, password)
-- INSERT INTO users (username, email, password) VALUES
-- ('Alice', 'alice@example.com', 'hashedpassword1'),
-- ('Bob', 'bob@example.com', 'hashedpassword2');

-- -- INSERT INTO categories (categorie_name)
-- INSERT INTO categories (categorie_name) VALUES
-- ('Men'),
-- ('Women'),
-- ('Kids');

-- -- INSERT INTO types_of_product (type_name)
-- INSERT INTO types_of_product (type_name) VALUES
-- ('T-Shirt'),
-- ('Jeans'),
-- ('Jacket'),
-- ('Sneakers'),
-- ('Dress');

-- -- INSERT INTO colors (color)
-- INSERT INTO colors (color) VALUES
-- ('Red'),
-- ('Blue'),
-- ('Black'),
-- ('White'),
-- ('Green');

-- -- INSERT INTO sizes (size_name)
-- INSERT INTO sizes (size_name) VALUES
-- ('S'),
-- ('M'),
-- ('L'),
-- ('XL'),
-- ('XXL');

-- -- Insert Products into my_store (example products)
-- INSERT INTO my_store (name_of_article, price, stock, color_id, size_id) VALUES
-- ('Basic Red T-Shirt', 25.99, 50, 1, 3), -- Red, Size L
-- ('Blue Slim Fit Jeans', 49.99, 30, 2, 4), -- Blue, Size XL
-- ('Black Leather Jacket', 79.99, 15, 3, 4), -- Black, Size XL
-- ('White Sneakers', 59.99, 20, 4, NULL), -- No size (shoes have different sizes)
-- ('Green Summer Dress', 45.99, 25, 5, 2); -- Green, Size M

-- -- Link Products to Categories
-- INSERT INTO product_categories (product_id, category_id) VALUES
-- (1, 1), -- T-Shirt -> Men
-- (2, 1), -- Jeans -> Men
-- (3, 1), -- Jacket -> Men
-- (4, 1), -- Sneakers -> Men
-- (5, 2); -- Dress -> Women

-- -- Link Products to Types
-- INSERT INTO product_types (product_id, type_id) VALUES
-- (1, 1), -- T-Shirt
-- (2, 2), -- Jeans
-- (3, 3), -- Jacket
-- (4, 4), -- Sneakers
-- (5, 5); -- Dress

-- -- Insert more Kids products into my_store
-- INSERT INTO my_store (name_of_article, price, stock, color_id, size_id) VALUES
-- ('Kids Red T-Shirt', 15.99, 50, 1, 1), 
-- ('Kids Blue T-Shirt', 15.99, 50, 2, 1), 
-- ('Kids Green Hoodie', 19.99, 30, 5, 2), 
-- ('Kids Yellow Sneakers', 25.99, 40, 4, NULL),
-- ('Kids Black Jeans', 22.99, 20, 3, 3),
-- ('Kids Pink Dress', 28.99, 25, 4, 2),
-- ('Kids Orange Jacket', 34.99, 15, 2, 3),
-- ('Kids Purple Sweater', 18.99, 30, 5, 1),
-- ('Kids Blue Shorts', 14.99, 35, 2, 2),
-- ('Kids Red Cap', 10.99, 60, 1, NULL),
-- ('Kids Green Pants', 21.99, 25, 5, 3),
-- ('Kids White Sneakers', 22.99, 30, 4, NULL),
-- ('Kids Yellow Skirt', 19.99, 30, 3, 1),
-- ('Kids Black Boots', 30.99, 20, 3, NULL),
-- ('Kids Pink Jacket', 32.99, 15, 4, 3),
-- ('Kids Blue Shirt', 20.99, 25, 2, 2),
-- ('Kids Purple Leggings', 17.99, 35, 5, 1),
-- ('Kids Red Dress', 25.99, 30, 1, 2),
-- ('Kids Green Sweater', 23.99, 40, 5, 1),
-- -- ('Kids Orange Sandals', 19.99, 50, 2, NULL);

-- -- Link Kids Products to Categories and Types
-- INSERT INTO product_categories (product_id, category_id) VALUES
-- (6, 3), -- Red T-Shirt -> Kids
-- (7, 3), -- Blue T-Shirt -> Kids
-- (8, 3), -- Green Hoodie -> Kids
-- (9, 3), -- Yellow Sneakers -> Kids
-- (10, 3), -- Black Jeans -> Kids
-- (11, 3), -- Pink Dress -> Kids
-- (12, 3), -- Orange Jacket -> Kids
-- (13, 3), -- Purple Sweater -> Kids
-- (14, 3), -- Blue Shorts -> Kids
-- (15, 3), -- Red Cap -> Kids
-- (16, 3), -- Green Pants -> Kids
-- (17, 3), -- White Sneakers -> Kids
-- (18, 3), -- Yellow Skirt -> Kids
-- (19, 3), -- Black Boots -> Kids
-- (20, 3), -- Pink Jacket -> Kids
-- (21, 3), -- Blue Shirt -> Kids
-- (22, 3), -- Purple Leggings -> Kids
-- (23, 3), -- Red Dress -> Kids
-- (24, 3), -- Green Sweater -> Kids
-- (25, 3); -- Orange Sandals -> Kids

-- -- Link Kids Products to Types
-- INSERT INTO product_types (product_id, type_id) VALUES
-- (6, 1), -- T-Shirt
-- (7, 1), -- T-Shirt
-- (8, 3), -- Hoodie
-- (9, 4), -- Sneakers
-- (10, 2), -- Jeans
-- (11, 5), -- Dress
-- (12, 3), -- Jacket
-- (13, 3), -- Sweater
-- (14, 2), -- Shorts
-- (15, 4), -- Cap
-- (16, 2), -- Pants
-- (17, 4), -- Sneakers
-- (18, 5), -- Skirt
-- (19, 4), -- Boots
-- (20, 3), -- Jacket
-- (21, 1), -- Shirt
-- (22, 2), -- Leggings
-- (23, 5), -- Dress
-- (24, 3), -- Sweater
-- (25, 4); -- Sandals


-- DELETE FROM product_categories WHERE category_id = (SELECT categorie_id FROM categories WHERE categorie_name = 'Kids');
-- DELETE FROM product_types WHERE product_id IN (SELECT product_id FROM product_categories WHERE category_id = (SELECT categorie_id FROM categories WHERE categorie_name = 'Kids'));


-- DELETE FROM categories WHERE categorie_name = 'Kids';

-- DELETE FROM my_store WHERE article_id IN (SELECT product_id FROM product_categories WHERE category_id = (SELECT categorie_id FROM categories WHERE categorie_name = 'Kids'));


-- -- Drop size and color columns from my_store table
-- ALTER TABLE my_store
--     DROP COLUMN size_id,
--     DROP COLUMN color_id;

-- CREATE TABLE product_sizes (
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     size_id INT REFERENCES sizes(size_id) ON DELETE CASCADE,
--     PRIMARY KEY (product_id, size_id)
-- );


-- CREATE TABLE product_colors (
--     product_id INT REFERENCES my_store(article_id) ON DELETE CASCADE,
--     color_id INT REFERENCES colors(color_id) ON DELETE CASCADE,
--     PRIMARY KEY (product_id, color_id)
-- );


-- -- Link Products to Sizes (assuming the product IDs and size IDs)
-- INSERT INTO product_sizes (product_id, size_id) VALUES
-- (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),  -- Basic Red T-Shirt -> all sizes
-- (2, 1), (2, 2), (2, 3), (2, 4), (2, 5),  -- Blue Slim Fit Jeans -> all sizes
-- (3, 1), (3, 2), (3, 3), (3, 4), (3, 5);  -- Black Leather Jacket -> all sizes
-- -- Repeat for all products...


-- -- Link Products to Colors (assuming the product IDs and color IDs)
-- INSERT INTO product_colors (product_id, color_id) VALUES
-- (1, 1), (1, 2), (1, 3),  -- Basic Red T-Shirt -> Red, Blue, Black
-- (2, 1), (2, 2), (2, 3),  -- Blue Slim Fit Jeans -> Red, Blue, Black
-- (3, 1), (3, 2), (3, 3);  -- Black Leather Jacket -> Red, Blue, Black
-- -- Repeat for all products...


-- SELECT * FROM product_colors


-- -- Insert more products for Women into my_store
-- INSERT INTO my_store (name_of_article, price, stock) VALUES
-- ('Women Red Blouse', 29.99, 40),
-- ('Women Blue Jeans', 49.99, 35),
-- ('Women Leather Handbag', 89.99, 20),
-- ('Women White Sneakers', 59.99, 25),
-- ('Women Floral Dress', 69.99, 30),
-- ('Women Black Skirt', 39.99, 40),
-- ('Women Wool Sweater', 54.99, 30),
-- ('Women Summer Hat', 19.99, 50),
-- ('Women Long Coat', 99.99, 15),
-- ('Women Sandals', 44.99, 35);

-- -- Link new Women products to Categories
-- INSERT INTO product_categories (product_id, category_id) VALUES
-- (26, 2), -- Red Blouse -> Women
-- (27, 2), -- Blue Jeans -> Women
-- (28, 2), -- Leather Handbag -> Women
-- (29, 2), -- White Sneakers -> Women
-- (30, 2), -- Floral Dress -> Women
-- (31, 2), -- Black Skirt -> Women
-- (32, 2), -- Wool Sweater -> Women
-- (33, 2), -- Summer Hat -> Women
-- (34, 2), -- Long Coat -> Women
-- (35, 2); -- Sandals -> Women

-- -- Link new Women products to Types
-- INSERT INTO product_types (product_id, type_id) VALUES
-- (26, 1), -- Blouse -> T-Shirt type
-- (27, 2), -- Jeans -> Jeans type
-- (28, 4), -- Handbag -> Sneakers type (adjust if needed)
-- (29, 4), -- Sneakers -> Sneakers type
-- (30, 5), -- Dress -> Dress type
-- (31, 3), -- Skirt -> Jacket type (adjust if needed)
-- (32, 3), -- Sweater -> Jacket type
-- (33, 7), -- Hat -> Cap type (adjust if needed)
-- (34, 3), -- Coat -> Jacket type
-- (35, 5); -- Sandals -> Dress type (adjust if needed)

-- -- Link new Women products to Colors
-- INSERT INTO product_colors (product_id, color_id) VALUES
-- (26, 1), -- Red Blouse -> Red
-- (27, 2), -- Blue Jeans -> Blue
-- (28, 3), -- Leather Handbag -> Black
-- (29, 4), -- White Sneakers -> White
-- (30, 5), -- Floral Dress -> Green
-- (31, 3), -- Black Skirt -> Black
-- (32, 5), -- Wool Sweater -> Green
-- (33, 4), -- Summer Hat -> White
-- (34, 3), -- Long Coat -> Black
-- (35, 4); -- Sandals -> White

-- -- Link new Women products to Sizes
-- INSERT INTO product_sizes (product_id, size_id) VALUES
-- (26, 2), (26, 3), (26, 4), -- Red Blouse -> M, L, XL
-- (27, 3), (27, 4), (27, 5), -- Blue Jeans -> L, XL, XXL
-- (28, 1), -- Handbag -> S (if applicable)
-- (29, 2), (29, 3), -- Sneakers -> M, L
-- (30, 2), (30, 3), (30, 4), -- Floral Dress -> M, L, XL
-- (31, 3), (31, 4), -- Black Skirt -> L, XL
-- (32, 4), (32, 5), -- Wool Sweater -> XL, XXL
-- (33, 1), -- Summer Hat -> S
-- (34, 4), (34, 5), -- Long Coat -> XL, XXL
-- (35, 2), (35, 3); -- Sandals -> M, L

-- -- Verify the inserted products
-- SELECT * FROM my_store WHERE article_id BETWEEN 26 AND 35;
-- SELECT * FROM product_categories WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_types WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_colors WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_sizes WHERE product_id BETWEEN 26 AND 35;



-- -- Insert more products for Women into my_store
-- INSERT INTO my_store (name_of_article, price, stock) VALUES
-- ('Women Red Blouse', 29.99, 40),
-- ('Women Blue Jeans', 49.99, 35),
-- ('Women Leather Jacket', 89.99, 20),
-- ('Women White Sneakers', 59.99, 25),
-- ('Women Floral Dress', 69.99, 30),
-- ('Women Black Skirt', 39.99, 40),
-- ('Women Wool Sweater', 54.99, 30),
-- ('Women Summer Hat', 19.99, 50),
-- ('Women Long Coat', 99.99, 15),
-- ('Women Sandals', 44.99, 35);

-- -- Link new Women products to Categories
-- INSERT INTO product_categories (product_id, category_id) VALUES
-- (27, 2), 
-- (28, 2), 
-- (29, 2), 
-- (30, 2), 
-- (31, 2), 
-- (32, 2), 
-- (33, 2), 
-- (34, 2), 
-- (35, 2); 

-- -- Ensure all necessary product types exist
-- INSERT INTO types_of_product (type_name) VALUES
-- ('Blouse'), ('Sweater'), ('Coat'), ('Hat'), ('Skirt'), ('Sandals')
-- ON CONFLICT (type_name) DO NOTHING;

-- Fetch type IDs for linking (for reference)
-- SELECT * FROM types_of_product;

-- -- Link new Women products to Types
-- INSERT INTO product_types (product_id, type_id) VALUES
-- (26, (SELECT type_id FROM types_of_product WHERE type_name = 'Blouse')),
-- (27, (SELECT type_id FROM types_of_product WHERE type_name = 'Jeans')),
-- (28, (SELECT type_id FROM types_of_product WHERE type_name = 'Jacket')),
-- (29, (SELECT type_id FROM types_of_product WHERE type_name = 'Sneakers')),
-- (30, (SELECT type_id FROM types_of_product WHERE type_name = 'Dress')),
-- (31, (SELECT type_id FROM types_of_product WHERE type_name = 'Skirt')),
-- (32, (SELECT type_id FROM types_of_product WHERE type_name = 'Sweater')),
-- (33, (SELECT type_id FROM types_of_product WHERE type_name = 'Hat')),
-- (34, (SELECT type_id FROM types_of_product WHERE type_name = 'Coat')),
-- (35, (SELECT type_id FROM types_of_product WHERE type_name = 'Sandals'));

-- -- Link new Women products to Colors
-- INSERT INTO product_colors (product_id, color_id) VALUES
-- (26, (SELECT color_id FROM colors WHERE color = 'Red')),
-- (27, (SELECT color_id FROM colors WHERE color = 'Blue')),
-- (28, (SELECT color_id FROM colors WHERE color = 'Black')),
-- (29, (SELECT color_id FROM colors WHERE color = 'White')),
-- (30, (SELECT color_id FROM colors WHERE color = 'Green')),
-- (31, (SELECT color_id FROM colors WHERE color = 'Black')),
-- (32, (SELECT color_id FROM colors WHERE color = 'Green')),
-- (33, (SELECT color_id FROM colors WHERE color = 'White')),
-- (34, (SELECT color_id FROM colors WHERE color = 'Black')),
-- (35, (SELECT color_id FROM colors WHERE color = 'White'));

-- -- Link new Women products to Sizes
-- INSERT INTO product_sizes (product_id, size_id) VALUES
-- (26, (SELECT size_id FROM sizes WHERE size_name = 'M')),
-- (26, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (26, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (27, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (27, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (27, (SELECT size_id FROM sizes WHERE size_name = 'XXL')),
-- (28, (SELECT size_id FROM sizes WHERE size_name = 'M')),
-- (28, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (29, (SELECT size_id FROM sizes WHERE size_name = 'M')),
-- (29, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (30, (SELECT size_id FROM sizes WHERE size_name = 'M')),
-- (30, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (30, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (31, (SELECT size_id FROM sizes WHERE size_name = 'L')),
-- (31, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (32, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (32, (SELECT size_id FROM sizes WHERE size_name = 'XXL')),
-- (33, (SELECT size_id FROM sizes WHERE size_name = 'S')),
-- (34, (SELECT size_id FROM sizes WHERE size_name = 'XL')),
-- (34, (SELECT size_id FROM sizes WHERE size_name = 'XXL')),
-- (35, (SELECT size_id FROM sizes WHERE size_name = 'M')),
-- (35, (SELECT size_id FROM sizes WHERE size_name = 'L'));

-- -- Verify the inserted products and associations
-- SELECT * FROM my_store WHERE article_id BETWEEN 26 AND 35;
-- SELECT * FROM product_categories WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_types WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_colors WHERE product_id BETWEEN 26 AND 35;
-- SELECT * FROM product_sizes WHERE product_id BETWEEN 26 AND 35;

