-- Module 2 · Subqueries
-- Date: 11/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Tours with price above the average tour price: tour_id, destination, price_usd.
SELECT tour_id, destination, price_usd
FROM tours
WHERE price_usd > (SELECT AVG(price_usd)
  FROM tours);

-- Exercise 2 ✓ solved
-- Names of agents who have at least one booking to Dubai. Use IN with a subquery.
SELECT agents.agent_name
FROM agents
WHERE agents.agent_id IN (SELECT bookings.agent_id
  FROM bookings
  JOIN tours ON bookings.tour_id = tours.tour_id
  WHERE tours.destination = 'Dubai');

-- Exercise 3 ✓ solved
-- Bookings whose total_usd is bigger than the average confirmed booking: booking_id, total_usd.
SELECT booking_id, total_usd
FROM bookings
WHERE total_usd > (SELECT AVG(total_usd)
  FROM bookings
  WHERE status = 'confirmed');

-- Exercise 4 ✓ solved
-- Average of agents' confirmed revenue: first sum revenue per agent in a subquery in FROM, then AVG it. Round to 0 decimals. One number.
SELECT ROUND(SUM(total_usd) * 1.0 / COUNT(DISTINCT agent_id), 0)
FROM bookings
WHERE status = 'confirmed';
