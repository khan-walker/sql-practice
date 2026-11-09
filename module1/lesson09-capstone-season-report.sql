-- Module 1 · Capstone: Season report
-- Date: 10/11/2026
-- Course database: agents, tours, bookings, payments

-- Task 1 ✓ solved
-- Cancellation rate: share of bookings that are cancelled, as a percentage rounded to 1 decimal (one number).
select round(100.0 * sum((case when status = 'cancelled' then 1 else 0 end)) / count(booking_id), 1) from bookings;

-- Task 2 ✓ solved
-- Top 3 agents by confirmed revenue: agent_name, city, revenue. Highest first.
select agents.agent_name, agents.city, sum(bookings.total_usd) as revenue from agents join bookings on agents.agent_id = bookings.agent_id where bookings.status = 'confirmed' group by bookings.agent_id order by revenue desc limit 3;

-- Task 3 ✓ solved
-- Per country: confirmed passengers and confirmed revenue, highest revenue first.
select tours.country, sum(bookings.pax), sum(bookings.total_usd) as revenue from tours join bookings on tours.tour_id = bookings.tour_id where bookings.status = 'confirmed' group by tours.country order by revenue desc;

-- Task 4 ✓ solved
-- Load per tour: tour_id, destination, start_date, confirmed pax, for the 5 tours with the most confirmed passengers (most first; ties by tour_id).
select tours.tour_id, tours.destination, tours.start_date, sum(bookings.pax) as p from tours join bookings on tours.tour_id = bookings.tour_id where bookings.status = 'confirmed' group by tours.tour_id order by p desc, tours.tour_id limit 5;

-- Task 5 ✓ solved
-- Agents with zero confirmed bookings in August 2026 departures (show agent_name). Stretch task: you need NOT IN with a subquery, a preview of Module 2.
select agent_name
from agents
where agent_id not in (
  select bookings.agent_id
  from bookings
  join tours on tours.tour_id = bookings.tour_id
  where bookings.status = 'confirmed'
    and tours.start_date >= '2026-08-01'
    and tours.start_date < '2026-09-01'
);
