#1 - Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;

SELECT *
FROM staff;

#2 - A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

#Customer with a first name including "charlotte"
SELECT *
FROM customer
WHERE first_name LIKE "%CHARLOTTE%";

#Format of the staff table
SELECT *
FROM staff;

#Add the new staff in the table staff
INSERT INTO staff
VALUES (3, "Charlotte", "Hunter", 134, "Charlotte.Hunter@sakilastaff.com", 2, 1, "Charlotte", "abcd", '2023-05-27 00:00:00');

#3 - Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.

#Columns format from rental table
SELECT *
FROM rental
ORDER BY rental_id desc;
-- We need the folowing columns : rental_id, rental_date (in this format: 2005-05-26 22:04:30), inventory_id, customer_id, return_date (in this format: 2005-05-26 22:04:30), staff_id, last_update (in this format: 2005-05-26 22:04:30)

SELECT *
FROM film
WHERE title = "Academy Dinosaur";
-- film_id is 1

#inventory_id for this movie
SELECT *
FROM inventory
WHERE film_id = 1;
-- inventory ids for store 1 are: 1, 2, 3, 4

#customer_id 
select customer_id from customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- customer_id for charlotte is 130

#staff_id
select * from staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';
-- staff_id for Mike Hillyer is 1

#add the new line in rental
INSERT INTO rental
VALUES (16050, '2023-05-27 15:12:00', 3, 130, '2023-06-01 15:12:00', 1, '2023-05-27 15:12:00');

#4 - Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

#Check if there are any non-active users
SELECT * FROM customer
WHERE active = 0;
-- THere are 15 non active users

#Create a blank table backup table
CREATE TABLE backup_table (
  `Customer_id` int UNIQUE NOT NULL,
  `Email` char(100) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (Customer_id)
);

select *
from backup_table;

#Insert the non active users in the table backup table
INSERT INTO backup_table (Customer_id, Email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

SET FOREIGN_KEY_CHECKS=0;

#Delete the non active users from the table customer
DELETE FROM customer
WHERE customer.active = 0;

SET FOREIGN_KEY_CHECKS=1;