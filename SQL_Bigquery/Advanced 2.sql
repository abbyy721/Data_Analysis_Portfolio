/* 

🔹 Advanced SQL Queries - Level 2
🔸 Skills used : WINDOW FUNCTIONS (LEAD, LAG, FIRST_VALUE, LAST_VALUE), FRAME FUNCTIONS

--------------------------------------------------------------------------------------------------------------------------

📘 Table Reference (1) : `array_exercises`

| row | user_id | visit_month |
|-----|---------|-------------|
| 1   | 1004    | 7           |
| 2   | 1004    | 3           |
| 3   | 1004    | 1           |
| 4   | 1004    | 8           |
| 5   | 2112    | 7           |
| 6   | 2112    | 3           |
| 7   | 2112    | 6           |
| 8   | 3912    | 4           |


--------------------------------------------------------------------------------------------------------------------------

📘 Table Reference (2) : `orders`

| row | order_id | order_date | user_id | amount |
|-----|----------|------------|---------|--------|
| 1   | 6        | 2023-05-03 | 1       | 90     |
| 2   | 3        | 2023-05-02 | 1       | 200    |
| 3   | 1        | 2023-05-01 | 1       | 100    |
| 4   | 9        | 2023-05-05 | 1       | 150    |
| 5   | 5        | 2023-05-03 | 2       | 180    |


--------------------------------------------------------------------------------------------------------------------------

📘 Table Reference (3) : `query_logs`

| user   | team          | first_query_date | last_query_date |
|--------|---------------|------------------|-----------------|
| Ella   | AI            | 2024-04-25       | 2024-05-01      |
| Wiliam | AI            | 2024-04-25       | 2024-04-25      |
| Cape   | AI            | 2024-04-24       | 2024-05-01      |
| Yoon   | Dev           | 2024-04-24       | 2024-05-01      |
| Jane   | Dev           | 2024-04-26       | 2024-04-26      |
| Kyle   | Coaching      | 2024-04-24       | 2024-05-01      | */


--------------------------------------------------------------------------------------------------------------------------


📄 Questions


/* Find each user’s next visit month and the following visit month.*/

  
SELECT
  *,
  LEAD (visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_visit,
  LEAD (visit_month,2) OVER (PARTITION BY user_id ORDER BY visit_month) AS third_visit
FROM `Advanced.analytics_function_01`
ORDER BY user_id


--------------------------------------------------------------------------------------------------------------------------

  
/* For each user, identify the previous, next, and second next visit months.*/

  
SELECT
  *,
  LEAD (visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_visit,
  LEAD (visit_month,2) OVER (PARTITION BY user_id ORDER BY visit_month) AS third_visit,
  LAG (visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS previous_visit
FROM `Advanced.analytics_function_01`
ORDER BY user_id


--------------------------------------------------------------------------------------------------------------------------

  
/* Calculate the time interval between consecutive visits for each user. */


SELECT
  *,
  next_visit - visit_month AS visit_diff
FROM (
  SELECT
    *,
    LEAD (visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS next_visit,
  FROM `Advanced.analytics_function_01`)
ORDER BY user_id

  
--------------------------------------------------------------------------------------------------------------------------


/* Find each user’s first visit month and last visit month. */

  
SELECT
  *,
  FIRST_VALUE(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS first_visit,
  LAST_VALUE(visit_month) OVER (PARTITION BY user_id ORDER BY visit_month) AS last_visit,
FROM `Advanced.analytics_function_01`
ORDER BY user_id

  
--------------------------------------------------------------------------------------------------------------------------

  
/* Write a SQL query on the orders table to:

1) Calculate the total order amount
2) Calculate the cumulative order amount
3) Calculate the cumulative order amount per user
4) Calculate the average order amount of the 5 most recent orders */ 

SELECT
  *,
  SUM(amount) OVER () AS amount_total,
  SUM(amount) OVER (ORDER BY order_id) AS cumulative_sum,
  SUM(amount) OVER (PARTITION BY user_id ORDER BY order_date) AS cumulative_sum_by_user,
  AVG(amount) OVER (PARTITION BY user_id ORDER BY order_date ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING) AS last_5_orders_avg
FROM `Advanced.orders`
ORDER BY user_id


--------------------------------------------------------------------------------------------------------------------------


/* Add a new column on the right to show the number of queries executed by each user. */ 


SELECT
  *,
  COUNT(query_date) OVER (PARTITION BY user ORDER BY user) AS user_count
FROM `Advanced.query_logs`


--------------------------------------------------------------------------------------------------------------------------
  
  
/* From the dataset,

1) Calculate the weekly query counts for each team member.
2) For each team, find the member with the highest number of queries executed in that week. */ 


WITH base AS (
  SELECT
    *,
    EXTRACT (WEEK FROM query_date) AS week_number,
    COUNT(query_date) OVER (PARTITION BY user ORDER BY query_date) AS query_cnt,
  FROM `Advanced.query_logs`), 
base2 AS (
SELECT
  *,
  DENSE_RANK() OVER (PARTITION BY team,week_number ORDER BY query_cnt DESC) AS rank_query_cnt
FROM base
GROUP BY ALL) 

SELECT
  user,
  team,week_number,
  query_cnt,
  rank_query_cnt
FROM base2
WHERE rank_query_cnt = 1
GROUP BY ALL
ORDER BY week_number, user, team


--------------------------------------------------------------------------------------------------------------------------
  




















