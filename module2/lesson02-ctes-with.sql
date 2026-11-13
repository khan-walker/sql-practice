-- Module 2 · CTEs: WITH
-- Date: 14/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 (not solved yet)
-- With a CTE dest_rev (confirmed revenue per destination), show destinations whose revenue is above the average destination revenue: destination, revenue.
WITH dest_rev AS (SELECT tours.destination AS d, SUM(total_usd) AS revenue
  FROM bookings
  JOIN tours ON bookings.tour_id = tours.tour_id
  WHERE status = 'confirmed'
  GROUP BY tours.destination)
SELECT dest_rev.d, dest_rev.revenue
FROM dest_rev
WHERE dest_rev.revenue > (SELECT AVG(revenue)
  FROM dest_rev);

-- Exercise 2 ✓ solved
-- Per agent: number of confirmed bookings and number of cancelled bookings (agent_name, confirmed, cancelled). Use a CTE, or CASE inside SUM.
SELECT a.agent_name, SUM(CASE WHEN b.status = 'confirmed' THEN 1 ELSE 0 END) AS confirmed, SUM(CASE WHEN b.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled
FROM agents a
LEFT JOIN bookings b ON b.agent_id = a.agent_id
GROUP BY a.agent_id, a.agent_name;

-- Exercise 3 ✓ solved
-- Cancellation rate per agent in percent (agent_name, rate rounded to 1 decimal), highest rate first, ties by agent_name.
WITH t AS (SELECT agent_id id, COUNT(status) a, SUM(CASE WHEN bookings.status = 'cancelled' THEN 1 ELSE 0 END) AS cancel
  FROM bookings
  GROUP BY agent_id)
SELECT agents.agent_name, ROUND(t.cancel * 100.0 / t.a, 1) AS rate
FROM agents
JOIN t ON agents.agent_id = t.id
GROUP BY agents.agent_name
ORDER BY rate DESC, agents.agent_name;
