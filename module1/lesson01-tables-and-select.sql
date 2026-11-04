-- Module 1 · Tables and SELECT
-- Date: 04/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Show all columns and all rows from the agents table.
SELECT * FROM agents;

-- Exercise 2 ✓ solved
-- Show only the destination and price_usd of every tour.
SELECT destination, price_usd FROM tours;

-- Exercise 3 ✓ solved
-- Show booking_id, pax and status from bookings.
SELECT booking_id, pax, status FROM bookings;
