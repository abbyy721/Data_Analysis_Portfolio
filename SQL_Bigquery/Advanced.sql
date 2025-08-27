/* 

🔹 Advanced SQL Queries - (1)
🔸 Skills used : ARRAY, STRUCT, UNNEST

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
|     |            |                 |              | session_id       |          |*/

    
--------------------------------------------------------------------------------------------------------------------------


📄 Questions


/* From the array_exercises table, UNNEST the genres array and display each movie (title) with its corresponding genres.*/

  
SELECT
  title, 
  genre
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST (genres) AS genre


--------------------------------------------------------------------------------------------------------------------------


/*From the array_exercises table, display each movie (title) with its actors (actor) and their roles (character). 
The actor and character should appear in separate columns.*/


SELECT
  title,
  actor.actor AS actor,
  actor.character AS character
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST (actors) AS actor


--------------------------------------------------------------------------------------------------------------------------


/*From the array_exercises table, display each movie (title) with its actors (actor), their roles (character), and its genres (genre). 
Each row should contain the actor, character, and genre together.*/


SELECT
  title, 
  actor.actor AS actor,
  actor.character AS character,
  genre
FROM `Advanced.array_exercises`
CROSS JOIN UNNEST(genres) AS genre, UNNEST(actors) AS actor


--------------------------------------------------------------------------------------------------------------------------

  
/*"From the app_logs table, UNNEST the array fields (e.g., event_params) to display them as separate rows.*/


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

  
/*How many times did each event occur on 2022-08-01?*/

  
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




