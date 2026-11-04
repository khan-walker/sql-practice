-- Module 1 · Filtering with WHERE
-- Date: 05/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Show all tours to Batumi.
select * from tours where destination = 'Batumi';

-- Exercise 2 ✓ solved
-- Show bookings with status cancelled.
select * from bookings where status = 'cancelled';

-- Exercise 3 ✓ solved
-- Show tours in Turkey that cost more than 700 USD per person.
select * from tours where price_usd > 700 and country = 'Turkey';

-- Exercise 4 ✓ solved
-- Show agents located in Tashkent or Samarkand. Use IN.
select * from agents where city in ('Tashkent','Samarkand');

-- Exercise 5 ✓ solved
-- Show tours that start in July 2026 (from 2026-07-01 to 2026-07-31).
select * from tours where start_date between '2026-07-01' and '2026-07-31';

-- Exercise 6 ✓ solved
-- Fix the bug. This should show confirmed bookings with 4 or more passengers.
SELECT * FROM bookings
WHERE status = 'confirmed' AND pax >= 4;
