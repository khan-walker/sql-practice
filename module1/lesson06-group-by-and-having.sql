-- Module 1 · GROUP BY and HAVING
-- Date: 08/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Number of tours per country (columns: country, count).
select country, count(tour_id) from tours group by country;

-- Exercise 2 ✓ solved
-- Confirmed revenue (SUM of total_usd) per agent_id, highest first.
select agent_id, sum(total_usd) as revenue from bookings where status = 'confirmed' group by agent_id order by revenue desc;

-- Exercise 3 ✓ solved
-- Average price per destination, rounded to 0 decimals.
select destination, round(avg(price_usd), 0) from tours group by destination;

-- Exercise 4 ✓ solved
-- Agents (agent_id and number of bookings) with more than 18 bookings of any status.
select agent_id, count(booking_id) from bookings group by agent_id having count(booking_id) > 18;

-- Exercise 5 ✓ solved
-- Fix the bug. Should show destinations with average price above 700.
SELECT destination, AVG(price_usd)
FROM tours
GROUP BY destination
having AVG(price_usd) > 700;
