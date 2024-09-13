--1. Find the senior most employee in music store.

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include data sorting and basic SQL queries.
--   Used FROM clause to check and use employee table for all the necessary details.  
--	 Used SELECT clause to pick necessary columns for complete employee records.
--	 Used ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT employee_id, first_name, last_name, levels
FROM employee
ORDER BY levels DESC
LIMIT 1;

--2. Top 5 Countries with most invoices.

--   Solution steps to address the question:

--a. Questions I asked to figure out how the solution will look like.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled ?

--b. Answers to the above questions using SQL queries:

--   The concepts applied include data aggregation, sorting, and basic SQL query.
--   Used FROM clause to check and use invoice table for all the necessary details.  
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Used GROUP BY clause to aggregate data based on country. ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT COUNT(invoice_id)AS invoices, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY invoices DESC
LIMIT 5;

--3. Find top 10 cities which has best customers to throw promotional music concerts? Evaluate by highest sum of invoice totals.

--   Solution steps to address the question:

--a. Questions I asked to figure out how the solution will look like.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled ?

--b. Answers to the above questions using SQL queries:

--   The concepts applied include data aggregation, sorting, and basic SQL query.
--   Used FROM clause to check and use invoice table for all the necessary details.  
--	 Used SELECT clause and applied agrreagate function to include necessary columns in the resulting table.
--	 Used GROUP BY clause to aggregate data based on city. ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT billing_city, SUM(total) AS invoice_totals
FROM invoice
GROUP BY billing_city
ORDER BY invoice_totals DESC
LIMIT 10;

--4. List Top 10 customer_id by transaction value. 

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include data sorting and basic SQL query.
--   Used FROM clause to check and use invoice table for all the necessary details.  
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Used ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT customer_id, total
FROM invoice
ORDER BY total DESC
LIMIT 10;

--5. Find out the best customer as per maximum spent on purchase.

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include joins, data aggregation, sorting, and basic SQL query.
--   Used FROM clause and employed JOIN operations between the customer and invoice tables based on common column to retrieve all the necessary details.
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Used GROUP BY clause to aggregate data based on customer_id. ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS invoice_total
FROM customer 
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY invoice_total DESC
LIMIT 1;

--6. Write a query to return customer_id, first name, last_name, email of all music listeners with Rock genre.

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include joins, sub-query, data sorting and filteration, and basic SQL query.
--   Used FROM clause and employed JOIN operations between 3 tables(customer, invoice, invoice_line) based on common column to retrieve all the necessary details.
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Used sub-query in WHERE clause and joined track and genre table to filter data based on genre. Used ORDER BY clause to sort result in ascending order.

SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, customer.email
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id
	FROM track 
	JOIN genre ON track.genre_id = genre.genre_id
    WHERE genre.name = 'Rock')
ORDER BY customer.email;

--7. Who are the top 10 artists and bands that have written and performed the most rock genre tracks?

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include joins, data aggregation, sorting and filteration, and basic SQL query.
--   To address the query, used FROM clause and employed JOIN operations between 4 tables(track, album, genre, artist) based on common column to retrieve all the necessary details.
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Filtered data using WHERE clause and used GROUP BY clause to aggregate data based on artist_id. Used ORDER BY and LIMIT clause to sort result in descending order and restrict the entries as per the desired result.

SELECT artist.artist_id, artist.name, COUNT(track.track_id) AS total_tracks
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id
ORDER BY total_tracks DESC
LIMIT 10;

--8. Return all track names and respective milliseconds values with song length longer than average song length. Order the results by song length in descending order of song length

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include sub-query in the WHERE clause, data sorting, filteration and basic SQL query.   
--   Used FROM clause to check and use track table for all the necessary details.  
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Filtered data based on track length. Used ORDER BY clause to sort resulting value in descending order.

SELECT "name", milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS average_track_length
	FROM track
	)
ORDER BY milliseconds DESC;

--9. Find the most popular music genres by country based on purchase volume. For each country, return the top genre(s) with the highest purchase count, including all genres tied for the maximum purchases.

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include window functions for ranking purpose, joins, data aggregation, sorting, and filteration, queried data using common table expressions(CTE) and then use it in the main query.
--   Used FROM clause in CTE and employed JOIN operations between 4 tables(track, customer, genre, invoice, invoice_line) based on common column to retrieve all the necessary details.
--   Used the SELECT clause to include necessary columns in the CTE and resulting table.
--	 Used GROUP BY to aggregate data by 2 columns (2,3). Applied ORDER BY to sort by 2nd column in the CTE. Filtered results using the WHERE clause in the main query to achieve the desired result.

WITH popular_genre AS
(
		SELECT COUNT(invoice_line.quantity) AS purchase_details, customer.country, genre.name,
		ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS row_num
		FROM invoice_line	
		JOIN invoice ON invoice.invoice_id= invoice_line.invoice_id
		JOIN customer ON customer.customer_id = invoice.customer_id
		JOIN track ON invoice_line.track_id= track.track_id
		JOIN genre ON track.genre_id= genre.genre_id
		GROUP BY 2,3	 
		ORDER BY 2 ASC
)

SELECT purchase_details, country, "name"
FROM popular_genre 
WHERE row_num <= 1;

--10. Write a query that returns the country, its top customer based on highest amount spent.

--   Solution steps to address the question:

--a. Questions to determine the results' appearance.

--   Which concepts need to be applied?
--   Which tables to check to get the required data? 
--	 Which columns to include in resulting table?
--	 What criteria needs to be fulfilled?

--b. Answers to the above questions using SQL queries.

--   The concepts applied include window functions for ranking purpose, data aggregation, sorting, filteration, queried data using common table expressions(CTE) and then use it in the main query.
--   Used FROM clause in CTE to check and use invoice table for all the necessary details.  
--   Used the SELECT clause to include necessary columns in the resulting table.
--	 Used GROUP BY to aggregate data by 2 columns (1,2). Applied ORDER BY to sort by 2 columns (2,3) in the CTE. Filtered results using the WHERE clause in the main query to achieve the desired result.

WITH cust_country_spent AS(
		SELECT customer_id, billing_country, SUM(total) AS total_spent,
		ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS row_num
		FROM invoice 
		GROUP BY 1,2
	    ORDER BY billing_country ASC, total_spent DESC  
)	
SELECT customer_id, billing_country, total_spent
FROM cust_country_spent
WHERE row_num <= 1;

-- End of this project

