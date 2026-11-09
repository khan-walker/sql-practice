-- Module 1 · Dates and monthly reports
-- Date: 09/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Number of tours per departure month (month as YYYY-MM, count), ordered by month.
select strftime('%Y-%m', start_date) as months, count(*)  from tours group by months order by months;

-- Exercise 2 ✓ solved
-- Confirmed revenue per departure month, ordered by month.
select strftime('%Y-%m', tours.start_date) as month, sum(bookings.total_usd) from bookings join tours on bookings.tour_id = tours.tour_id where bookings.status = 'confirmed' group  by month order by month;

-- Exercise 3 ✓ solved
-- Average lead time in days (start_date minus booking_date), rounded to 1 decimal, per destination.
select tours.destination, round(avg(julianday(tours.start_date) - julianday(bookings.booking_date)), 1) from tours join bookings on bookings.tour_id = tours.tour_id group by tours.destination;
