-- Module 1 · Calculations and CASE
-- Date: 08/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Show booking_id, total_usd and a column commission equal to 10% of total_usd.
select booking_id, total_usd, total_usd * 0.1 as comission from bookings;

-- Exercise 2 ✓ solved
-- Show tour_id, destination and per_night = price_usd divided by nights, rounded to 2 decimals.
select tour_id, destination, round(price_usd * 1.0 / nights, 2) as per_night from tours;

-- Exercise 3 ✓ solved
-- Show tour_id, price_usd and band: 'budget' if price is under 600, 'standard' if under 750, otherwise 'premium'.
select tour_id, price_usd, 
case
when price_usd < 600 then 'budget'
when price_usd < 750 then 'standard'
else 'premium'
end as band from tours;
