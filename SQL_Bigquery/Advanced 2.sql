/* 

🔹 Advanced SQL Queries - (2)
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
| 8   | 3912    | 4           |*/

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











