/* 

🔹 Advanced SQL Queries - Level 1
🔸 Skills used : ARRAY, STRUCT, UNNEST, PIVOT 

--------------------------------------------------------------------------------------------------------------------------

📘 Table Reference (1) : `array_exercises`

CREATE OR REPLACE TABLE Advanced.array_exercises AS
SELECT movie_id, title, actors, genres
FROM (
  SELECT 
    1 AS movie_id, 
    'Avengers: Endgame' AS title, 
    ARRAY<STRUCT<actor STRING, character STRING>>[
      STRUCT('Robert Downey Jr.', 'Tony Stark'), 
      STRUCT('Chris Evans', 'Steve Rogers')
    ] AS actors, 
    ARRAY<STRING>['Action', 'Adventure', 'Drama'] AS genres
  UNION ALL
  SELECT 
    2, 
    'Inception', 
    ARRAY<STRUCT<actor STRING, character STRING>>[
      STRUCT('Leonardo DiCaprio', 'Cobb'), 
      STRUCT('Joseph Gordon-Levitt', 'Arthur')
    ], 
    ARRAY<STRING>['Action', 'Adventure', 'Sci-Fi']
  UNION ALL
  SELECT 
    3, 
    'The Dark Knight', 
    ARRAY<STRUCT<actor STRING, character STRING>>[
      STRUCT('Christian Bale', 'Bruce Wayne'), 
      STRUCT('Heath Ledger', 'Joker')
    ], 
    ARRAY<STRING>['Action', 'Crime', 'Drama']
)*/

--------------------------------------------------------------------------------------------------------------------------


📘 Table Reference (2) : `app_logs`

/* This table contains sample event logs with nested event_params.
Each event has a date, timestamp, name, user information, and platform.
The event_params field includes keys such as firebase_screen and session_id, with associated string or integer values.

### Sample Table Reference (`array_exercises`)

| row | event_date | event_timestamp | event_name   | event_params.key | platform |
|-----|------------|-----------------|--------------|------------------|----------|
| 1   | 2022-08-22 | 1661094060000000 | screen_view | firebase_screen  | iOS      |
|     |            |                 |              | session_id       |          |
| 2   | 2022-08-22 | 1661094071000000 | click_login | firebase_screen  | iOS      |
|     |            |                 |              | session_id       |          |
| 3   | 2022-08-22 | 1661094071337104 | screen_view | firebase_screen  | iOS      |
|     |            |                 |              | session_id       |          |
| 4   | 2022-08-22 | 1661094720000000 | screen_view | firebase_screen  | Android  |
|     |            |                 |              | session_id       |          |

    
--------------------------------------------------------------------------------------------------------------------------


📘 Table Reference (3) : `orders`

### Sample Orders Table

| row | order_id | order_date | user_id | amount |
|-----|----------|------------|---------|--------|
| 1   | 6        | 2023-05-03 | 1       | 90     |
| 2   | 3        | 2023-05-02 | 1       | 200    |
| 3   | 1        | 2023-05-01 | 1       | 100    |
| 4   | 9        | 2023-05-05 | 1       | 150    |
| 5   | 5        | 2023-05-03 | 2       | 180    |
| 6   | 2        | 2023-05-01 | 2       | 150    |
| 7   | 8        | 2023-05-04 | 2       | 200    |
| 8   | 4        | 2023-05-02 | 3       | 120    |
| 9   | 7        | 2023-05-04 | 3       | 220    |*/

    
--------------------------------------------------------------------------------------------------------------------------


📄 Questions


/* From the array_exercises table, UNNEST the genres array and display each movie (title) with its corresponding genres.*/

  
SELECT
  title, 
  genre
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST (genres) AS genre


--------------------------------------------------------------------------------------------------------------------------


/* From the array_exercises table, display each movie (title) with its actors (actor) and their roles (character). 
The actor and character should appear in separate columns. */


SELECT
  title,
  actor.actor AS actor,
  actor.character AS character
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST (actors) AS actor


--------------------------------------------------------------------------------------------------------------------------


/* From the array_exercises table, display each movie (title) with its actors (actor), their roles (character), and its genres (genre). 
Each row should contain the actor, character, and genre together. */


SELECT
  title, 
  actor.actor AS actor,
  actor.character AS character,
  genre
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST(genres) AS genre, UNNEST(actors) AS actor


--------------------------------------------------------------------------------------------------------------------------

  
/* From the app_logs table, UNNEST the array fields (e.g., event_params) to display them as separate rows. */


SELECT
  event_date, 
  event_timestamp, 
  event_name, 
  user_id, 
  user_pseudo_id,
  platform, 
  key,
  value.string_value,
  value.int_value
FROM `Advanced.app_logs`
CROSS JOIN UNNEST (event_params) AS param


--------------------------------------------------------------------------------------------------------------------------

  
/* How many times did each event occur on 2022-08-01? */

  
WITH sample AS (
  SELECT
    event_date, 
    event_timestamp, 
    event_name, 
    user_id, 
    user_pseudo_id,
    platform, 
    key,
    value.string_value,
    value.int_value
  FROM `Advanced.app_logs`
  CROSS JOIN UNNEST (event_params) AS param) 

SELECT
  event_date, 
  event_name, 
  COUNT(DISTINCT user_id) AS cnt_event 
FROM sample
WHERE event_date = '2022-08-01'
GROUP BY ALL 
ORDER BY cnt_event DESC


--------------------------------------------------------------------------------------------------------------------------


/* From the orders table, create a PIVOT table that shows the sum of order amounts (amount) by user (user_id).
The rows should represent order_date, and the columns should represent user_id. */


SELECT
  order_date,
  SUM(IF(user_id=1,amount,NULL)) AS user_1,
  SUM(IF(user_id=2,amount,NULL)) AS user_2,
  SUM(IF(user_id=3,amount,NULL)) AS user_3,
FROM `Advanced.orders`
GROUP BY order_date
ORDER BY order_date 


--------------------------------------------------------------------------------------------------------------------------


/* From the orders table, create a PIVOT table that shows the sum of order amounts (amount) by date (order_date). 
  The rows should represent user_id, and the columns should represent order_date. */


SELECT
  user_id, 
  SUM(IF(order_date = '2023-05-01',amount,NULL)) AS `2023-05-01`,
  SUM(IF(order_date = '2023-05-02',amount,NULL)) AS `2023-05-02`,
  SUM(IF(order_date = '2023-05-03',amount,NULL)) AS `2023-05-03`,
  SUM(IF(order_date = '2023-05-04',amount,NULL)) AS `2023-05-04`,
  SUM(IF(order_date = '2023-05-05',amount,NULL)) AS `2023-05-05`
FROM `Advanced.orders`
GROUP BY user_id


--------------------------------------------------------------------------------------------------------------------------


/* From the orders table, create a PIVOT table that shows whether each user (user_id) placed an order on each date (order_date).
If an order exists, display 1; if not, display 0. 
The rows should represent user_id, and the columns should represent order_date. 
Multiple orders on the same date should still be counted as 1. */

  
SELECT
  user_id,
  MAX(IF(order_date = '2023-05-01', 1, 0)) AS `2023-05-01`,
  MAX(IF(order_date = '2023-05-02', 1, 0)) AS `2023-05-02`,
  MAX(IF(order_date = '2023-05-03', 1, 0)) AS `2023-05-03`,
  MAX(IF(order_date = '2023-05-04', 1, 0)) AS `2023-05-04`,
  MAX(IF(order_date = '2023-05-05', 1, 0)) AS `2023-05-05`
FROM `Advanced.orders`
GROUP BY user_id


--------------------------------------------------------------------------------------------------------------------------


/* Given the raw 'app_logs' data with event parameters stored as key–value pairs,  
write a query to transform the data into the following table structure: 

| event_date | steps_number | event_name_screen         | cnt |
|------------|--------------|---------------------------|-----|
| 2022-08-01 | 1            | screen_view-welcome       | 156 |
| 2022-08-01 | 2            | screen_view-home          | 129 |
| 2022-08-01 | 3            | screen_view-food_category | 51  |*/


WITH base AS (
SELECT
  event_date, 
  DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime,
  CONCAT (event_name,'-',value.string_value) AS event_name_screen,
  user_id,
  user_pseudo_id
FROM `Advanced.app_logs`
CROSS JOIN UNNEST (event_params) AS params
WHERE event_date BETWEEN '2022-08-01' AND '2022-08-22'
  AND key = 'firebase_screen' 
  AND event_name IN ('screen_view','click_payment')
), 
base2 AS (
SELECT
  event_date,
  base.event_name_screen,
  CASE
    WHEN base.event_name_screen = 'screen_view-welcome' THEN 1 
    WHEN base.event_name_screen = 'screen_view-home' THEN 2
    WHEN base.event_name_screen = 'screen_view-food_category' THEN 3 
    WHEN base.event_name_screen = 'screen_view-restaurant' THEN 4
    WHEN base.event_name_screen = 'screen_view-cart' THEN 5
    WHEN base.event_name_screen = 'click_payment-cart' THEN 6
    ELSE NULL END AS steps_number,
  user_id,
  user_pseudo_id,
FROM base 
ORDER BY steps_number)

SELECT
  event_date,
  steps_number,
  event_name_screen,
  COUNT (DISTINCT (user_pseudo_id)) AS cnt,
FROM base2
WHERE steps_number IS NOT NULL 
GROUP BY event_date, steps_number, event_name_screen
ORDER BY event_date, steps_number, event_name_screen


--------------------------------------------------------------------------------------------------------------------------









