-- Module 1 · Sorting, LIMIT, DISTINCT, aliases
-- Date: 07/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Show the 5 most expensive tours (all columns), most expensive first.
SELECT * FROM tours order by price_usd desc limit 5;

-- Exercise 2 ✓ solved
-- List every destination once (one column, destination).
select distinct destination from tours;

-- Exercise 3 ✓ solved
-- Show booking_id and total_usd renamed as revenue for the 3 biggest confirmed bookings, biggest first.
select booking_id, total_usd as revenue from bookings where status = 'confirmed' order by total_usd desc limit 3;

-- Exercise 4 ✓ solved
-- Show all agents sorted by city A–Z, then by agent_name A–Z.
select * from agents order by city, agent_name;

-- Exercise 5 ✓ solved
-- Fix the bug. Should show the 3 cheapest tours, cheapest first (if prices are equal, lower tour_id first).
SELECT * FROM tours
ORDER BY price_usd, tour_id
LIMIT 3;`lesson04-calculations-and-case.sql
