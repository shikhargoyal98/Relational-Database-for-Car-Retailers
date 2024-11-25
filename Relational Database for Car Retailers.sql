
USE shg23026_group7; -- query should be run using database shg23026_group7

CREATE TABLE `brands` (
  `brand_id` int(10) PRIMARY KEY,
  `brand_name` varchar(30) DEFAULT NULL,
  `Subbrand_Sport_ID` int(10) DEFAULT NULL,
  `SubbrandCategory` varchar(30) DEFAULT NULL
);



CREATE TABLE `categories`(
  `category_id` int(10) PRIMARY KEY,
  `category_name` varchar(30) DEFAULT NULL,
  `Sub_Category_ID` int(10) DEFAULT NULL,
  `Sub_Category` varchar(30) DEFAULT NULL
);


CREATE TABLE `customers`(
  `customer_id` int(10) PRIMARY KEY,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `phone` int(10) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `zip_code` int(6) DEFAULT NULL
);

CREATE TABLE `stores` (
  `store_id` int(10) PRIMARY KEY,
  `store_name` varchar(30) DEFAULT NULL,
  `phone` int(10) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `zip_code` int(6) DEFAULT NULL
);


CREATE TABLE `products` (
  `product_id` int(10) PRIMARY KEY,
  `product_name` varchar(30) DEFAULT NULL,
  `brand_id` int(10),
  `category_id` int(10),
  `model_year` year(4) DEFAULT NULL,
  `list_price` int(10) DEFAULT NULL,
  `product_type` varchar(30) DEFAULT NULL, -- Subtype discriminator
   CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
   CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
  `inventory_id` int(10)
);

-- shg23026_group7.stocks definition

CREATE TABLE `inventory` (
  `inventory_id` int(10) PRIMARY KEY,
  `store_id` int(10),
  `product_id` int(10),
  `quantity` int(10) DEFAULT NULL,
  `Inventory_Status` varchar(30) DEFAULT NULL,
 CONSTRAINT fk_invstore FOREIGN KEY (store_id) REFERENCES stores(store_id),
 CONSTRAINT fk_invproduct FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- shg23026_group7.staffs definition

CREATE TABLE `employees` (
  `emp_id` int(10) PRIMARY KEY,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` int(10) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `store_id` int(10),
  `manager_id` int(10),
  CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- shg23026_group7.orders definition

CREATE TABLE `Orders` (
  `order_id` int(10) PRIMARY KEY,
  `order_status` varchar(30) DEFAULT NULL,
  `order_date` DATE DEFAULT NULL,
  `required_date` DATE DEFAULT NULL,
  `shipped_date` DATE DEFAULT NULL,
  `customer_id` int(10),
  `store_id` int(10),
  `emp_id` int(10),
   CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
   CONSTRAINT fk_stores FOREIGN KEY (store_id) REFERENCES stores(store_id),
   CONSTRAINT fk_employees FOREIGN KEY (emp_id) REFERENCES employees(emp_id)  
);

-- shg23026_group7.order_items definition

CREATE TABLE `order_items`(
  `order_id` int(10),
  `item_id` int(10) PRIMARY KEY,
  `product_id` int(10),
  `quantity` int(10) DEFAULT NULL,
  `list_price` int(10) DEFAULT NULL,
  `discount` int(10) DEFAULT NULL,
   CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
   CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- SHOW TABLES;


ALTER table products
ADD CONSTRAINT fk_prodinven FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id);

ALTER TABLE employees
ADD CONSTRAINT fk_empmanager FOREIGN KEY (manager_id) REFERENCES employees(emp_id);

ALTER table products 
ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id);

-- DELETE FROM customers;

/* ALTER TABLE customers MODIFY phone INT(20);

ALTER TABLE employees MODIFY phone INT(15);

ALTER TABLE stores MODIFY phone INT(15);*/

-- ALTER TABLE customers 
-- DROP CONSTRAINT unique_emailcust;

ALTER TABLE customers
MODIFY phone VARCHAR(15);  -- Change to VARCHAR

ALTER TABLE employees 
MODIFY phone VARCHAR(15);  -- Change to VARCHAR

ALTER TABLE stores 
MODIFY phone VARCHAR(15);  -- Change to VARCHAR

ALTER TABLE customers
ADD CONSTRAINT chk_phonecust CHECK (LENGTH(phone) = 10);

ALTER TABLE employees 
ADD CONSTRAINT chk_phoneemply CHECK (LENGTH(phone) = 10);

ALTER TABLE stores 
ADD CONSTRAINT chk_phonestor CHECK (LENGTH(phone) = 10);

/* ALTER TABLE customers
ADD CONSTRAINT chk_phonecust CHECK (phone BETWEEN 1000000000 AND 9999999999);

ALTER TABLE employees 
ADD CONSTRAINT chk_phoneempl CHECK (phone BETWEEN 1000000000 AND 9999999999);

ALTER TABLE stores 
ADD CONSTRAINT chk_phonestor CHECK (phone BETWEEN 1000000000 AND 9999999999);*/

ALTER TABLE customers
ADD CONSTRAINT unique_emailcust UNIQUE (email);

ALTER TABLE employees 
ADD CONSTRAINT unique_emailempl UNIQUE (email);

ALTER TABLE stores 
ADD CONSTRAINT unique_emailstor UNIQUE (email);

-- Inserting Valid data to test constraints
INSERT INTO customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES
(1, 'Alice', 'Smith', '1234567899', 'alice@example.com', '123 Main St', 'Anytown', 'NY', 12345),
(2, 'Bob', 'Johnson', '9876543219', 'bob@example.com', '456 Elm St', 'Othertown', 'CA', 54321);

-- Inserting invalid data to test constraints
INSERT INTO customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES
(3, 'Al', 'Sm', '1234567898', 'alice@example.com', '12 Main St', 'Anown', 'NZ', 12375),
(4, 'Bb', 'Joon', '9876543218', 'alice@example.com', '46 Elm St', 'Ortown', 'CT', 54311);

SELECT * FROM customers c ;

INSERT INTO customers (phone, email) VALUES
('12345', 'charlie@example.com'); -- Invalid phone number

INSERT INTO customers (phone, email) VALUES
('5555555555', 'dave@example.com');

INSERT INTO customers (phone, email) VALUES
('4444444444', 'alice@example.com'); -- Duplicate email

Create table hatchback ( 
hatch_id int(10) PRIMARY KEY, 
product_id int(10), 
model varchar(30)DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_hatch FOREIGN KEY (product_id) REFERENCES products(product_id)
); 


Create table minivan( 
my_id  int(10) primary key, 
product_id int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_minivan FOREIGN KEY (product_id) REFERENCES products(product_id)
);

Create table sedan(
sedan_id  int(10) primary key, 
product_id int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_sedan FOREIGN KEY (product_id) REFERENCES products(product_id)
); 

Create table SUV_Sport_Utility_Vehicle(
SUV_id int(10) primary key, 
product_id int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_SUV FOREIGN KEY (product_id) REFERENCES products(product_id)
); 

Create table coupe ( 
couple_id int(10) primary key, 
product_id  int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4)DEFAULT NULL,
CONSTRAINT fk_coupe FOREIGN KEY (product_id) REFERENCES products(product_id)
);

Create table convertible(
conv_id int(10) primary key, 
product_id int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_convertible FOREIGN KEY (product_id) REFERENCES products(product_id)
); 

Create table pickup_truck(
pkt_id int(10) primary key, 
product_id int(10), 
model varchar(30) DEFAULT NULL, 
year Year(4) DEFAULT NULL,
CONSTRAINT fk_pickup FOREIGN KEY (product_id) REFERENCES products(product_id)
);

ALTER TABLE coupe 
RENAME COLUMN couple_id TO coupe_id;

ALTER TABLE minivan 
RENAME COLUMN my_id TO mv_id;

SELECT * FROM employees e ;

ALTER TABLE products 
MODIFY product_name VARCHAR(100);

ALTER TABLE products DROP CONSTRAINT fk_empmanager;

DELETE  FROM employees ;

INSERT INTO employees (emp_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES
(31, 'Oliver', 'Smith', 'Oliver.Smith@bikes.shop', '8315555584', 1, 2, 1),
(32, 'Emma', 'Johnson', 'Emma.Johnson@bikes.shop', '8315555585', 1, 2, 1),
(33, 'Liam', 'Williams', 'Liam.Williams@bikes.shop', '8315555586', 1, 3, 2),
(34, 'Sophia', 'Jones', 'Sophia.Jones@bikes.shop', '8315555587', 1, 3, 2),
(35, 'Noah', 'Brown', 'Noah.Brown@bikes.shop', '8315555588', 1, 1, 3),
(36, 'Ava', 'Davis', 'Ava.Davis@bikes.shop', '8315555589', 1, 1, 3),
(37, 'Lucas', 'Miller', 'Lucas.Miller@bikes.shop', '8315555590', 1, 2, 4),
(38, 'Mia', 'Wilson', 'Mia.Wilson@bikes.shop', '8315555591', 1, 2, 4),
(39, 'Ethan', 'Moore', 'Ethan.Moore@bikes.shop', '8315555592', 1, 3, 5),
(40, 'Isabella', 'Taylor', 'Isabella.Taylor@bikes.shop', '8315555593', 1, 3, 5);

INSERT INTO employees (emp_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES
(41, 'James', 'Anderson', 'James.Anderson@bikes.shop', '8315555594', 1, 1, 1),
(42, 'Charlotte', 'Thomas', 'Charlotte.Thomas@bikes.shop', '8315555595', 1, 1, 2),
(43, 'Benjamin', 'Jackson', 'Benjamin.Jackson@bikes.shop', '8315555596', 1, 2, 1),
(44, 'Amelia', 'White', 'Amelia.White@bikes.shop', '8315555597', 1, 2, 2),
(45, 'Henry', 'Harris', 'Henry.Harris@bikes.shop', '8315555598', 1, 3, 3),
(46, 'Ella', 'Martin', 'Ella.Martin@bikes.shop', '8315555599', 1, 3, 4),
(47, 'Alexander', 'Thompson', 'Alexander.Thompson@bikes.shop', '8315555500', 1, 1, 1),
(48, 'Grace', 'Garcia', 'Grace.Garcia@bikes.shop', '8315555501', 1, 1, 2),
(49, 'Daniel', 'Martinez', 'Daniel.Martinez@bikes.shop', '8315555502', 1, 2, 3),
(50, 'Sofia', 'Robinson', 'Sofia.Robinson@bikes.shop', '8315555503', 1, 2, 4);


INSERT INTO stores (store_id, store_name, phone, email, street, city, state, zip_code) VALUES
(4, 'Pacific Ridge Bikes', '9725305556', 'pacific@bikes.shop', '1234 Ocean View Drive', 'Santa Cruz', 'CA', '75089'),
(5, 'Crestview Bikes', '9725305557', 'crestview@bikes.shop', '5678 Mountain Road', 'Baldwin', 'NY', '75090'),
(6, 'Maple Grove Bikes', '9725305558', 'maple@bikes.shop', '9101 Lake Park Drive', 'Rowlett', 'TX', '75091'),
(7, 'Silver Lake Bikes', '9725305559', 'silver@bikes.shop', '2345 Willow Street', 'Pacific Ridge', 'CA', '75092'),
(8, 'Redwood Trail Bikes', '9725305560', 'redwood@bikes.shop', '6789 Maple Avenue', 'Crestview', 'NY', '75093'),
(9, 'Mountain Peak Bikes', '9725305561', 'mountain@bikes.shop', '3456 Pine Crest Lane', 'Silver Lake', 'TX', '75094'),
(10, 'Valley Forge Bikes', '9725305562', 'valley@bikes.shop', '7890 Cedar Ridge Drive', 'Redwood Trail', 'CA', '75095'),
(11, 'Lakeview Bikes', '9725305563', 'lakeview@bikes.shop', '1357 Riverbend Way', 'Valley Forge', 'NY', '75096'),
(12, 'Horizon Bikes', '9725305564', 'horizon@bikes.shop', '2468 Summit Avenue', 'Lakeview', 'CA', '75097'),
(13, 'Summit Ridge Bikes', '9725305565', 'summit@bikes.shop', '3690 Horizon Boulevard', 'Mountain Peak', 'TX', '75098'),
(14, 'Riverbend Bikes', '9725305566', 'riverbend@bikes.shop', '4821 Valley Road', 'Canyon View', 'NY', '75099'),
(15, 'Cedar Hill Bikes', '9725305567', 'cedar@bikes.shop', '5932 Sunset Lane', 'Pine Valley', 'CA', '75100'),
(16, 'Canyon View Bikes', '9725305568', 'canyon@bikes.shop', '7043 Timberline Drive', 'Desert Oasis', 'TX', '75101'),
(17, 'Pine Valley Bikes', '9725305569', 'pine@bikes.shop', '8154 Coastal Way', 'Cedar Hill', 'NY', '75102'),
(18, 'Desert Oasis Bikes', '9725305570', 'desert@bikes.shop', '9265 Meadowbrook Circle', 'Aspen Grove', 'CA', '75103'),
(19, 'Coastal Breeze Bikes', '9725305571', 'coastal@bikes.shop', '1350 Blue Ridge Trail', 'Sunrise', 'TX', '75104'),
(20, 'Timberline Bikes', '9725305572', 'timberline@bikes.shop', '2461 Autumn Lane', 'Wildflower', 'NY', '75105'),
(21, 'Willow Creek Bikes', '9725305573', 'willow@bikes.shop', '3572 Crystal Drive', 'Skyline', 'CA', '75106'),
(22, 'Sunrise Bikes', '9725305574', 'sunrise@bikes.shop', '4683 Evergreen Way', 'Crystal Lake', 'NY', '75107'),
(23, 'Meadowbrook Bikes', '9725305575', 'meadowbrook@bikes.shop', '5794 Alpine Street', 'Ironwood', 'CA', '75108'),
(24, 'Wildflower Bikes', '9725305576', 'wildflower@bikes.shop', '6805 Fairview Drive', 'Seaside', 'TX', '75109'),
(25, 'Aspen Grove Bikes', '9725305577', 'aspen@bikes.shop', '7916 Horizon Ridge', 'Coastal Breeze', 'CA', '75110'),
(26, 'Skyline Bikes', '9725305578', 'skyline@bikes.shop', '8027 Valley Vista Road', 'Timberline', 'NY', '75111'),
(27, 'Blue Ridge Bikes', '9725305579', 'blue@bikes.shop', '9138 Creekside Drive', 'Willow Creek', 'TX', '75112'),
(28, 'Crystal Lake Bikes', '9725305580', 'crystal@bikes.shop', '1240 Ocean Breeze Lane', 'Maple Grove', 'CA', '75113'),
(29, 'Evergreen Bikes', '9725305581', 'evergreen@bikes.shop', '2351 Lakeview Boulevard', 'Riverbend', 'NY', '75114'),
(30, 'Ironwood Bikes', '9725305582', 'ironwood@bikes.shop', '3462 Highland Drive', 'Cedar Hill', 'TX', '75115');


DESCRIBE Orders ;


-- Top 10 Best-Selling Cars: Identify the top 10 cars sold over a specific period based on the quantity sold.

SELECT UPPER(p.product_name) AS Product_name, SUM(oi.quantity) AS Total,
    CASE 
        WHEN SUM(oi.quantity) >= 155 THEN 'High Demand'  -- High sales volume
        WHEN SUM(oi.quantity) BETWEEN 140 AND 154 THEN 'Moderate Demand'  -- Moderate sales volume
        ELSE 'Low Demand'  -- Low sales volume
    END AS Demand_Category
FROM products p 
LEFT JOIN order_items oi
ON
p.product_id = oi.product_id
LEFT JOIN Orders o 
ON
oi.order_id = o.order_id 
where o.order_status = '4' -- Order_status 4 means order is completed
GROUP BY p.product_name 
ORDER BY TOTAL DESC
LIMIT 10; -- using limit function to display only 10 rows ordered in descending order





-- Sales by Category: Top Car Categories like sedan, SUV etc. which one is having highest average selling price and having high discount

SELECT p.product_type , 

CONCAT('$', ROUND(AVG((oi.list_price - (oi.list_price*(oi.discount/100)))), 2)) AS Selling_Price, 
SUM(oi.quantity) AS Quantity_Sold,
CONCAT(ROUND(AVG(oi.discount), 2), '%') AS AVERAGE_DISCOUNT,

CASE
    WHEN ROUND(AVG(oi.discount), 2) > 8 THEN 'High Discount' -- Discount greater than 20% is High Discount
    WHEN ROUND(AVG(oi.discount), 2) BETWEEN 7.77 AND 7.9 THEN 'Medium Discount' -- Discount between 10% and 20% is Medium Discount
    -- WHEN ROUND(AVG(oi.discount), 2) BETWEEN 0 AND 10 THEN 'Low Discount' -- Discount between 0% and 10% is Low Discount
    ELSE 'Low Discount' -- If there's no discount
END AS Discount_Category
       
FROM products p
LEFT JOIN order_items oi
ON
p.product_id = oi.product_id
LEFT JOIN Orders o 
ON
oi.order_id = o.order_id 
where o.order_status = '4'
GROUP BY p.product_type 
ORDER BY ROUND(AVG((oi.list_price - (oi.list_price*(oi.discount/100)))), 2) DESC;





-- Most Active Customers: Identify the top customers based on their purchasE history
SELECT COALESCE(COUNT(o.order_id),0) AS total_orders, -- Using Count function to count the number of orders placed by a customer
	  c.customer_id, 
	  LOWER(c.first_name) AS First_Name,
	  LOWER(c.last_name) AS Last_Name,
	  CONCAT(UPPER(c.first_name), ' ', UPPER(c.last_name)) AS Full_Name, -- Displaying the customer details
    CASE 											
        WHEN COUNT(o.order_id) >= 3 THEN 'Loyal Customers'   -- Assigning "Loyal Customers" to customers having order placed >= 3
        WHEN COUNT(o.order_id) BETWEEN 2 AND 3 THEN 'Potential Customers'-- Assigning "Potential Customers" to customers having order placed between 2and3
        ELSE 'Occasional Customers' -- Customers placing less than 2 will be assigned "Occasional Customers"
    END AS Activity_level
FROM customers c 
LEFT JOIN Orders o 
ON
c.customer_id = o.customer_id 
GROUP BY c.customer_id 
ORDER BY COUNT(o.order_id) DESC
LIMIT 10;


-- 4 Store Sales Performance: Total sales revenue generated by each store, 
-- by which we can identify the highest-performing store.
-- High Sales Stores
SELECT s.store_name, 
       CONCAT('$', ROUND(SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))), 2)) AS Selling_Price,
       'High Sales' AS Sales_Performance
FROM stores s
LEFT JOIN Orders o2 ON s.store_id = o2.store_id
LEFT JOIN order_items oi ON o2.order_id = oi.order_id
WHERE o2.order_status = '4'
GROUP BY s.store_name
HAVING SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))) > 200000

UNION ALL

-- Medium Sales Stores
SELECT s.store_name, 
       CONCAT('$', ROUND(SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))), 2)) AS Selling_Price,
       'Medium Sales' AS Sales_Performance
FROM stores s
LEFT JOIN Orders o2 ON s.store_id = o2.store_id
LEFT JOIN order_items oi ON o2.order_id = oi.order_id
WHERE o2.order_status = '4'
GROUP BY s.store_name
HAVING SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))) BETWEEN 150000 AND 200000

UNION ALL

-- Low Sales Stores
SELECT s.store_name, 
       CONCAT('$', ROUND(SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))), 2)) AS Selling_Price,
       'Low Sales' AS Sales_Performance
FROM stores s
LEFT JOIN Orders o2 ON s.store_id = o2.store_id
LEFT JOIN order_items oi ON o2.order_id = oi.order_id
WHERE o2.order_status = '4'
GROUP BY s.store_name
HAVING SUM((oi.list_price - (oi.list_price * (oi.discount / 100)))) <= 150000
ORDER BY Selling_Price DESC;


-- 5 Store with Most Units Sold: Determine which store sold the most no. of vehicles
SELECT s.store_name, SUM(oi.quantity) AS Total_Quantity_Sold,
    CASE
        WHEN SUM(oi.quantity) > 250 THEN 'Top Performer'
        WHEN SUM(oi.quantity) BETWEEN 200 AND 250 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS Store_Performance
FROM stores s 
LEFT JOIN Orders o 
ON
s.store_id = o.store_id
LEFT JOIN order_items oi 
ON
o.order_id = oi.order_id 
where o.order_status = '4' -- Order_status 4 means order is completed
GROUP BY s.store_name 
ORDER BY SUM(oi.quantity) DESC ;



-- Which Car is having maximum and minimum stock units
CREATE VIEW Car_Maximum_Stock AS 
SELECT p.product_name, SUM(i.quantity) AS Total_Stock_Units
FROM products p 
LEFT JOIN inventory i 
ON
p.product_id = i.product_id 
GROUP BY p.product_name
ORDER BY SUM(i.quantity) DESC 
LIMIT 1;

CREATE VIEW Car_Minimum_Stock AS 
SELECT p.product_name, SUM(i.quantity) AS Total_Stock_Units
FROM products p 
LEFT JOIN inventory i 
ON
p.product_id = i.product_id 
GROUP BY p.product_name
ORDER BY SUM(i.quantity) 
LIMIT 1;

SELECT 

    Car_Maximum_Stock.product_name AS Max_Stock_Product, 
    
    Car_Minimum_Stock.product_name AS Min_Stock_Product

FROM Car_Maximum_Stock
    
CROSS JOIN Car_Minimum_Stock;

-- Top 3 Selling Brand
SELECT subquery.brand_name,
       CONCAT('$', ROUND(subquery.avg_selling_price, 2)) AS Selling_Price,
       CASE
           WHEN subquery.avg_selling_price > 2000 THEN 'High Selling Brand'
           WHEN subquery.avg_selling_price BETWEEN 1800 AND 2000 THEN 'Medium Selling Brand'
           ELSE 'Low Selling Brand'
       END AS Brand_Sales
FROM (
    SELECT b.brand_name,
           AVG(oi.list_price - (oi.list_price * (oi.discount / 100))) AS avg_selling_price
    FROM brands b
    LEFT JOIN products p ON b.brand_id = p.brand_id
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY b.brand_name
    ORDER BY avg_selling_price DESC
    LIMIT 3
) AS subquery;

-- Top 3 Selling Brand (Without subquery)
SELECT b.brand_name , CONCAT('$', ROUND(AVG((oi.list_price - (oi.list_price*(oi.discount/100)))), 2)) AS Selling_Price,
    CASE
        WHEN AVG((oi.list_price - (oi.list_price * (oi.discount / 100)))) > 2000 THEN 'High Selling Brand'
        WHEN AVG((oi.list_price - (oi.list_price * (oi.discount / 100)))) BETWEEN 1800 AND 2000 THEN 'Medium Selling Brand'
        ELSE 'Low Selling Brand'
    END AS Brand_Sales
FROM brands b 
LEFT JOIN products p 
ON
b.brand_id = p.brand_id
LEFT JOIN order_items oi 
ON
p.product_id = oi.product_id 
GROUP BY b.brand_name 
ORDER BY ROUND(AVG((oi.list_price - (oi.list_price*(oi.discount/100)))), 2) DESC 
LIMIT 3;

UPDATE stores
SET store_name = REPLACE(store_name, 'Bikes', 'Cars')
WHERE store_name LIKE '%Bikes%';


-- 5 Store with Most Units Sold: Determine which store sold the most no. of vehicles
WITH StoreSales AS (
    SELECT 
        s.store_name, 
        oi.quantity,
        SUM(oi.quantity) OVER (PARTITION BY s.store_name) AS Total_Quantity_Sold
    FROM stores s
    LEFT JOIN Orders o ON s.store_id = o.store_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = '4'  -- Order_status 4 means order is completed
)
SELECT 
    store_name, 
    Total_Quantity_Sold,
    CASE
        WHEN Total_Quantity_Sold > 250 THEN 'Top Performer'
        WHEN Total_Quantity_Sold BETWEEN 200 AND 250 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS Store_Performance
FROM StoreSales
GROUP BY store_name, Total_Quantity_Sold
ORDER BY Total_Quantity_Sold DESC;


-- Most Active Customers: Identify the top customers based on their purchasE history
WITH CustomerActivity AS (
    SELECT 
        c.customer_id,
        LOWER(c.first_name) AS First_Name,
        LOWER(c.last_name) AS Last_Name,
        CONCAT(UPPER(c.first_name), ' ', UPPER(c.last_name)) AS Full_Name,
        COUNT(o.order_id) OVER (PARTITION BY c.customer_id) AS total_orders
    FROM customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
)
, CustomerPerformance AS (
    SELECT 
        customer_id,
        First_Name,
        Last_Name,
        Full_Name,
        total_orders,
        CASE
            WHEN total_orders >= 3 THEN 'Loyal Customers'
            WHEN total_orders BETWEEN 2 AND 3 THEN 'Potential Customers'
            ELSE 'Occasional Customers'
        END AS Activity_level,
        ROW_NUMBER() OVER (ORDER BY total_orders DESC) AS rank
    FROM CustomerActivity
)
SELECT 
    total_orders,
    customer_id,
    First_Name,
    Last_Name,
    Full_Name,
    Activity_level
FROM CustomerPerformance
WHERE rank <= 10
ORDER BY total_orders DESC;


-- Most Active Customers: Identify the top customers based on their purchasE history
SELECT 
    COALESCE(total_orders, 0) AS total_orders, 
    c.customer_id, 
    LOWER(c.first_name) AS First_Name,
    LOWER(c.last_name) AS Last_Name,
    CONCAT(UPPER(c.first_name), ' ', UPPER(c.last_name)) AS Full_Name,
    CASE
        WHEN total_orders > 3 THEN 'Loyal Customers'
        WHEN total_orders BETWEEN 2 AND 3 THEN 'Potential Customers'
        ELSE 'Occasional Customers'
    END AS Activity_level
FROM customers c
LEFT JOIN (
    SELECT 
        o.customer_id, 
        COUNT(o.order_id) AS total_orders
    FROM Orders o
    GROUP BY o.customer_id
) AS order_counts 
ON c.customer_id = order_counts.customer_id
ORDER BY total_orders DESC
LIMIT 10;

