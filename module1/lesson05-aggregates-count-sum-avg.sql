-- Module 1 · Aggregates: COUNT, SUM, AVG
-- Date: 08/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- How many tours are there? Return one column n.
select count(*) as n from tours;

-- Exercise 2 ✓ solved
-- Total passengers (SUM(pax)) in confirmed bookings.
select sum(pax) from bookings where status='confirmed';

-- Exercise 3 ✓ solved
-- Average tour price, rounded to 1 decimal.
select round(sum(price_usd) * 1.0 / count(tour_id), 1) from tours;

-- Exercise 4 ✓ solved
-- How many different agents have at least one booking? Use COUNT(DISTINCT …).
select count(distinct agent_id) from bookings;
