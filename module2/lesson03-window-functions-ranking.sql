-- Module 2 · Window functions: ranking
-- Date: 16/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- For every tour: tour_id, destination, price_usd and rnk = RANK of price within its destination, most expensive = 1.
SELECT tour_id, destination, price_usd, RANK() OVER (PARTITION BY destination ORDER BY price_usd DESC) AS rnk
FROM tours;

-- Exercise 2 ✓ solved
-- The single most expensive tour per destination (destination, tour_id, price_usd). If tied, take the lowest tour_id.
WITH tour AS (SELECT destination, tour_id, price_usd, ROW_NUMBER() OVER (PARTITION BY destination ORDER BY price_usd DESC) AS rn
  FROM tours)
SELECT destination, tour_id, price_usd
FROM tour
WHERE rn <= 1;

-- Exercise 3 ✓ solved
-- Top 2 confirmed bookings by total_usd for each agent: agent_id, booking_id, total_usd. Ties broken by booking_id.
WITH booking AS (SELECT agent_id, booking_id, total_usd, ROW_NUMBER() OVER (PARTITION BY agent_id ORDER BY total_usd DESC, booking_id) AS rn
  FROM bookings
  WHERE status = 'confirmed')
SELECT agent_id, booking_id, total_usd
FROM booking
WHERE rn <= 2;

-- Exercise 4 ✓ solved
-- Each confirmed booking with its share of its agent's confirmed revenue in percent: booking_id, agent_id, share (rounded 1 decimal).
WITH booking AS (SELECT booking_id, agent_id, total_usd, ROW_NUMBER() OVER (PARTITION BY agent_id) AS rn
  FROM bookings
  WHERE status = 'confirmed')
SELECT booking_id, agent_id, ROUND(100.0 * total_usd / (SUM(total_usd) OVER (PARTITION BY agent_id)), 1) AS share
FROM booking;

-- Exercise 5 ✓ solved
-- Interview classic: rank scores. Rank every tour by price_usd, highest first, with no gaps after ties (900, 800, 800, 700 → 1, 2, 2, 3). Show tour_id, price_usd, rnk.
SELECT tour_id, price_usd, DENSE_RANK() OVER (ORDER BY price_usd DESC) AS rnk
FROM tours;

-- Exercise 6 ✓ solved
-- Interview classic: Nth highest. The 3rd highest distinct tour price. One number.
WITH tour AS (SELECT tour_id, price_usd, DENSE_RANK() OVER (ORDER BY price_usd DESC) AS rnk
  FROM tours)
SELECT DISTINCT price_usd
FROM tour
WHERE rnk = 3;

-- Exercise 7 ✓ solved
-- Interview classic: top 3 per group. For each destination, the tours whose price is among that destination's 3 highest distinct prices: destination, tour_id, price_usd.
WITH tour AS (SELECT destination, tour_id, price_usd, DENSE_RANK() OVER (PARTITION BY destination ORDER BY price_usd DESC) AS RANK
  FROM tours)
SELECT destination, tour_id, price_usd
FROM tour
WHERE RANK <= 3;

-- Exercise 8 ✓ solved
-- Interview classic: second record per group. Each agent's second booking (by booking_date; ties: lower booking_id): agent_id, booking_id, booking_date.
WITH booking AS (SELECT agent_id, booking_id, booking_date, ROW_NUMBER() OVER (PARTITION BY agent_id ORDER BY booking_date, booking_id) AS rn
  FROM bookings)
SELECT agent_id, booking_id, booking_date
FROM booking
WHERE rn = 2;
