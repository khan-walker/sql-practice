-- Module 2 · Running totals and growth
-- Date: 16/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Confirmed passengers per departure month with a running total: month, pax, cumulative. Ordered by month.
WITH tour AS (SELECT STRFTIME("%Y-%m", tours.start_date) AS month, SUM(bookings.pax) AS pax
  FROM bookings
  JOIN tours ON bookings.tour_id = tours.tour_id
  WHERE bookings.status = 'confirmed'
  GROUP BY month)
SELECT month, pax, SUM(pax) OVER (ORDER BY month) AS cumulative
FROM tour
ORDER BY month;

-- Exercise 2 ✓ solved
-- Monthly confirmed revenue with previous month's revenue: month, revenue, prev. Ordered by month.
WITH rev AS (SELECT STRFTIME('%Y-%m', tours.start_date) AS month, SUM(bookings.total_usd) AS revenue
  FROM bookings
  JOIN tours ON tours.tour_id = bookings.tour_id
  WHERE status = 'confirmed'
  GROUP BY month)
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month)
FROM rev
ORDER BY month;

-- Exercise 3 ✓ solved
-- Add MoM growth: month, revenue, growth_pct rounded to 1 decimal. Ordered by month.
WITH rev AS (SELECT STRFTIME('%Y-%m', tours.start_date) AS month, SUM(bookings.total_usd) AS revenue
  FROM bookings
  JOIN tours ON tours.tour_id = bookings.tour_id
  WHERE status = 'confirmed'
  GROUP BY month), second AS (SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS l
  FROM rev
  ORDER BY month)
SELECT month, revenue, ROUND((revenue - l) * 100.0 / l, 1)
FROM second;

-- Exercise 4 ✓ solved
-- For each tour, show tour_id, destination, start_date and next_start = start date of the next tour to the same destination.
WITH tour AS (SELECT tour_id, destination, start_date, LEAD(start_date) OVER (PARTITION BY destination ORDER BY start_date) AS next_start
  FROM tours)
SELECT tour_id, destination, start_date, next_start
FROM tour;
