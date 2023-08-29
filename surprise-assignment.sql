CREATE TABLE customer_dimension (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
)


CREATE TABLE fact_rentals (
    rental_id INT PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    rental_date DATE,
    return_date DATE,
    rental_fee NUMERIC
)


CREATE TABLE agg_customer_summary (
    customer_id INT PRIMARY KEY,
    total_movies_rented INT,
    total_paid NUMERIC,
    average_rental_duration NUMERIC
)

INSERT INTO agg_customer_summary(customer_id, total_movies_rented, total_paid, average_rental_duration)
SELECT
	myrental.customer_id,
	COUNT(myrental.rental_id) as total_movies_rented,
	AVG(mypayment.amount) as total_paid,
	COALESCE(AVG(EXTRACT(EPOCH FROM (myrental.return_date - myrental.rental_date))/86400),0) as average_rental_duration -- to get it by days
FROM public.rental as myrental
LEFT OUTER JOIN public.payment as mypayment
ON myrental.customer_id = mypayment.customer_id
GROUP BY
	myrental.customer_id














