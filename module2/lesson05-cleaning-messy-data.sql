-- Module 2 · Cleaning messy data
-- Date: 20/11/2026
-- Course database: agents, tours, bookings, payments

-- Exercise 1 ✓ solved
-- Count payments per cleaned method: method_clean (lowercase, trimmed, NULL → 'unknown') and count.
SELECT COALESCE(LOWER(TRIM(method)), 'unknown') AS method_clean, COUNT(*)
FROM payments
GROUP BY 1;

-- Exercise 2 ✓ solved
-- Total of all payment amounts as a number (clean the " USD" text first). One number.
SELECT SUM(CAST(REPLACE(amount, ' USD', '') AS INTEGER)) AS amount_sum
FROM payments;

-- Exercise 3 ✓ solved
-- Find duplicate payments: booking_id, amount, paid_on, and count, for combinations appearing more than once.
SELECT booking_id, amount, paid_on, COUNT(*) AS cnt
FROM payments
GROUP BY booking_id, amount, paid_on
HAVING COUNT(*) > 1;

-- Exercise 4 ✓ solved
-- Reconciliation: confirmed bookings where paid amount (cleaned, duplicates included) differs from total_usd. Show booking_id, total_usd, paid.
WITH payment AS (SELECT booking_id, SUM(amount) AS amount
  FROM payments
  GROUP BY booking_id)
SELECT bookings.booking_id, bookings.total_usd, payment.amount AS paid
FROM bookings
JOIN payment ON bookings.booking_id = payment.booking_id
WHERE status = 'confirmed'
  AND bookings.total_usd != payment.amount;

-- Exercise 5 ✓ solved
-- List the extra copies: payment_id of every payment that repeats an earlier one (same booking_id, same cleaned amount, same paid_on). Keep the lowest payment_id as the original. Order by payment_id.
WITH payment AS (SELECT payment_id, booking_id,
CAST(REPLACE(amount, ' USD', '') AS INTEGER) as amount, paid_on, ROW_NUMBER() OVER (PARTITION BY booking_id, CAST(REPLACE(amount, " USD", "") AS INTEGER), paid_on
order by payment_id) AS rn
FROM payments)
SELECT payment_id
FROM payment
where rn > 1
ORDER BY payment_id;

-- Exercise 6 ✓ solved
-- Total of all payments without duplicates (cleaned amounts, one copy of each). One number.
select sum(amount) from payments where payment_id not in (WITH payment AS (SELECT payment_id, booking_id,
CAST(REPLACE(amount, ' USD', '') AS INTEGER) as amount, paid_on, ROW_NUMBER() OVER (PARTITION BY booking_id, CAST(REPLACE(amount, " USD", "") AS INTEGER), paid_on
order by payment_id) AS rn
FROM payments)
SELECT payment_id
FROM payment
where rn > 1
ORDER BY payment_id);
