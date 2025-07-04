{{ config(materialized='table') }}

WITH days AS (
  SELECT
    ROW_NUMBER() OVER (ORDER BY seq4()) - 1 AS seq_num,
    DATEADD('day', ROW_NUMBER() OVER (ORDER BY seq4()) - 1, '1970-01-01'::date) AS date_day
  FROM TABLE(GENERATOR(ROWCOUNT => 366 * 200))
),
calendar AS (
  SELECT
    date_day::date AS date,
    EXTRACT(year FROM date_day)::int AS year,
    EXTRACT(month FROM date_day)::int AS month,
    EXTRACT(day FROM date_day)::int AS day,
    TO_VARCHAR(date_day, 'YYYY-MM') AS year_month,
    EXTRACT(quarter FROM date_day)::int AS quarter,
    TO_VARCHAR(date_day, 'Month') AS month_name,
    DAYNAME(date_day) AS day_name,
    EXTRACT(dayofweekiso FROM date_day)::int AS iso_day_of_week,
    EXTRACT(weekiso FROM date_day)::int AS iso_week,
    ROW_NUMBER() OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(quarter FROM date_day)
                       ORDER BY date_day) AS day_of_quarter,
    CASE WHEN DAYOFWEEK(date_day) IN (6,7) THEN 0 ELSE 1 END AS weekday_flag
  FROM days
  WHERE EXTRACT(year FROM date_day) BETWEEN 1970 AND 2169
)

SELECT * FROM calendar

