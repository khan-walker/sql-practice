-- Module 1 · JOINs: combining tables
-- Date: 09/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Show booking_id, agent_name and status for every booking.
SELECT b.booking_id, a.agent_name, b.status
FROM bookings AS b
JOIN agents AS a ON b.agent_id = a.agent_id;

-- Exercise 2 ✓ solved
-- Confirmed revenue per agent_name, highest first.
SELECT agents.agent_name, SUM(bookings.total_usd) AS summa
FROM agents
JOIN bookings ON bookings.agent_id = agents.agent_id
WHERE status = 'confirmed'
GROUP BY agents.agent_name
ORDER BY summa DESC;

-- Exercise 3 ✓ solved
-- Confirmed passengers (SUM of pax) per destination.
SELECT tours.destination, SUM(bookings.pax)
FROM tours
JOIN bookings ON tours.tour_id = bookings.tour_tid
WHERE bookings.status = 'confirmed'
GROUP BY tours.destination;

-- Exercise 4 ✓ solved
-- Find tours with no bookings at all: show tour_id, destination, start_date.
SELECT tours.tour_id, tours.destination, tours.start_date
FROM tours
LEFT JOIN bookings ON tours.tour_id = bookings.tour_id
WHERE bookings.pax IS NULL;

-- Exercise 5 ✓ solved
-- Fix the bug. Should list booking_id with the tour destination.
SELECT b.booking_id, t.destination
FROM bookings b
JOIN tours t ON t.tour_id = b.tour_id;
