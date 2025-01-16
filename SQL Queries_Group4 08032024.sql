/*SQL QUERIES*/

/* Query 1 -->  AS keyword */

SELECT pass_word AS Password, username AS Username FROM Users
order by username;

/* Query 2 -->  OR keyword */

SELECT * from Concert where city_name = 'Helsinki' OR city_name ='Turku';

/* Query 3 -->  AND keyword */

SELECT * from Artist where artist_name LIKE 'K%' AND artist_name like '%ä';

/* Query 4 -->  A) AGGREGATE FUNCTION  */

select order_ID AS ID, MIN(discount_price) AS 'Minimum Discount', order_date AS 'Order Date', user_ID AS 'User', first_name AS 'First Name', last_name AS 'Last Name'
from Purchase_Order 
group by order_ID
order by discount_price;

/* Query 5 -->  INNER JOIN keyword*/

SELECT coupon_code AS 'Coupon Code', title AS Deal, city_name AS City, discount_price AS 'Discount Price' from Coupon
INNER JOIN Concert ON Coupon.concert_ID = Concert.concert_ID
where discount_price > 20;

/* Query 6 -->  GROUP BY, INNER JOIN, ORDER BY, AGGREGATION FUNCTION */
/* Select the coupon_ID, the number of purchases made for each coupon, and the total revenue generated for each coupon. */ 

SELECT Coupon.coupon_ID, COUNT(*) AS Number_of_Purchases, SUM(total_price) AS Total_Revenue 
FROM Purchase_Order 
INNER JOIN Coupon ON Purchase_Order.coupon_code = Coupon.coupon_code 
GROUP BY Coupon.coupon_ID
ORDER BY Coupon.coupon_ID;


/* Query 7 -->  LEFT JOIN */

SELECT  City.city_name, Venue.venue_name
FROM City
LEFT JOIN Venue ON Venue.city_ID = City.city_ID;

/* Query 8-->  GROUP BY/HAVING   */
/* Select the concert names and the number of tickets purchased for concerts with more than 2 tickets purchased*/

SELECT Concert.concert_name, SUM(Purchase_Order.quantity) AS total_quantity
FROM Concert
INNER JOIN Coupon ON Concert.concert_ID = Coupon.concert_ID
INNER JOIN Purchase_Order ON Coupon.coupon_code = Purchase_Order.coupon_code
GROUP BY Concert.concert_name
HAVING SUM(Purchase_Order.quantity) > 2;

/* Query 9 -->  INNER JOIN   */
/* Select the username, first name, last name, and coupon code of users who have made purchases*/

SELECT Users.username, Users.first_name, Users.last_name, Purchase_Order.coupon_code 
FROM Users 
INNER JOIN Purchase_Order ON Users.user_ID = Purchase_Order.user_ID;

/* Query 10 -->  RIGHT JOIN  */

SELECT  City.city_name, Concert.concert_name
FROM City
Right JOIN Concert ON Concert.city_ID = City.city_ID;
