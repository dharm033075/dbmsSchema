USE sakila;
\!. echo "-----------------------SQL Assignment 1------------------------------------------------------"
\! echo "Find out the PG-13 rated comedy movies. DO NOT use the film_list table."
SELECT film.title FROM film_category AS fc 
INNER JOIN category AS c ON fc.category_id=c.category_id 
INNER JOIN film ON fc.film_id = film.film_id 
WHERE c.name='Comedy' AND film.rating='PG-13';

\! echo "Find out the top 3 rented horror movies."
SELECT film.title AS Top_3, count(film.film_id) AS num FROM film_category AS fc 
INNER JOIN category AS c ON fc.category_id=c.category_id AND c.name='Horror' 
INNER JOIN film ON fc.film_id = film.film_id 
INNER JOIN inventory AS iv ON film.film_id=iv.film_id 
INNER JOIN rental AS r ON iv.inventory_id=r.inventory_id 
GROUP BY film.film_id ORDER BY num desc limit 3;

\! echo "Find out the list of customers from India who have rented sports movies."
SELECT DISTINCT CONCAT(customer.first_name," ",customer.lASt_name) AS cusomer_list FROM film_category 
INNER JOIN category ON film_category.category_id=category.category_id AND category.name='Sports' 
INNER JOIN film ON film_category.film_id=film.film_id 
INNER JOIN inventory ON film.film_id=inventory.film_id 
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id 
INNER JOIN customer ON rental.customer_id=customer.customer_id 
INNER JOIN address ON customer.address_id= address.address_id 
INNER JOIN city ON address.city_id=city.city_id 
INNER JOIN country ON city.country_id=country.country_id WHERE country.country='India';

\! echo "Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies."
SELECT DISTINCT CONCAT(c.first_name," ",c.lASt_name) AS Customers FROM film_actor
INNER JOIN actor ON film_actor.actor_id=actor.actor_id 
INNER JOIN film ON film_actor.film_id=film.film_id 
INNER JOIN inventory AS iv ON film.film_id=iv.film_id 
INNER JOIN rental AS r ON iv.inventory_id = r.inventory_id 
INNER JOIN customer  AS c ON r.customer_id=c.customer_id 
INNER JOIN address ON c.address_id=address.address_id 
INNER JOIN city ON address.city_id=city.city_id 
INNER JOIN country ON city.country_id=country.country_id 
WHERE actor.first_name='Nick' AND actor.last_name='WAHLBERG' AND country.country='Canada';

\! echo "Find out the number of movies in which “SEAN WILLIAMS” acted."
SELECT DISTINCT count(film.film_id) AS FilmsActedIn FROM film_actor
INNER JOIN actor ON film_actor.actor_id=actor.actor_id 
INNER JOIN film ON film_actor.film_id=film.film_id 
WHERE actor.first_name='SEAN' AND actor.last_name='WILLIAMS';


\! echo"--------------------------------SQL assignment 2-------------------------------------------------"
use sakila;

\! echo "Find out the number of documentaries with deleted scenes."
SELECT count(film.film_id) AS Numberoffilms FROM film_category AS fc 
INNER JOIN category AS c ON fc. category_id = c.category_id AND c.name='Documentary' 
INNER JOIN film ON fc.film_id=film.film_id WHERE film.special_features='Deleted Scenes';

\! echo "Find out the number of sci-fi movies rented by the store managed by Jon Stephens."
SELECT count(film.film_id) AS NumOfSciFiMov FROM film_category AS fc 
INNER JOIN category AS c ON fc.category_id=c.category_id 
INNER JOIN film ON fc.film_id = film.film_id 
INNER JOIN inventory AS iv ON film.film_id=iv.film_id 
INNER JOIN rental AS r ON r.inventory_id=iv.inventory_id 
INNER JOIN staff ON r.staff_id=staff.staff_id 
WHERE c.name='Sci-Fi'AND staff.first_name='JON' AND staff.LASt_name='Stephens';/* remove it group by*/

\! echo "Find out the total sales from Animation movies."
SELECT c.name,sum(payment.amount) AS TotalSales FROM film_category AS fc 
INNER JOIN category AS c ON fc.category_id=c.category_id 
INNER JOIN film ON fc.film_id = film.film_id 
INNER JOIN inventory AS iv ON iv.film_id=film.film_id 
INNER JOIN rental AS r ON iv.inventory_id=r.inventory_id 
INNER JOIN payment ON r.rental_id=payment.rental_id 
WHERE c.name='AnimatiON'/* remove it group by*/

\! echo "Find out the top 3 rented category of movies  by PATRICIA JOHNSON"
SELECT c.name AS Movie,count(c.name) AS top3Movies FROM customer AS cr 
INNER JOIN rental AS r ON cr.customer_id=r.customer_id 
INNER JOIN inventory AS iv ON r.inventory_id = iv.inventory_id 
INNER JOIN film ON iv.film_id=film.film_id 
INNER JOIN film_category AS fc ON film.film_id=fc.film_id 
INNER JOIN category AS c ON fc.category_id =c.category_id 
WHERE cr.first_name='PATRICIA' AND cr.lASt_name='JOHNSON' 
GROUP BY c.name ORDER BY top3Movies desc limit 3;

\! echo "Find out the number of R rated movies rented by SUSAN WILSON"
SELECT count(film.film_id) AS R_rated_Mov FROM customer AS cr 
INNER JOIN rental AS r ON cr.customer_id=r.customer_id 
INNER JOIN inventory AS iv ON r.inventory_id = iv.inventory_id 
INNER JOIN film ON iv.film_id=film.film_id 
INNER JOIN film_category AS fc ON film.film_id=fc.film_id 
INNER JOIN category AS c ON fc.category_id =c.category_id 
WHERE film.rating='R' AND cr.first_name='SUSAN' AND cr.lASt_name='WILSON';/* remove it group by*/