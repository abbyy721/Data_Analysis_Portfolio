/* 

🔹 Basic SQL Queries - Level 3
🔸 Skills used : 
- STRING FUNCTIONS (CONCAT, SPLIT, REPLACE, TRIM, UPPER)
- DATE/TIME FUNCTIONS (TIMESTAMP, DATETIME, EXTRACT, TRUNC, PARSE, FORMAT, LAST_DAY, DATETIME_DIFF )


📘 Table Reference (1) : `trainer`
| column                 | type   | description                            |
|------------------------|--------|----------------------------------------|
| id                     | INT    | Unique trainer ID                      |
| name                   | STRING | Trainer name                           |
| age                    | INT    | Trainer's age                          |
| hometown               | STRING | City the trainer is from               |
| preferred_pokemon_type | STRING | Favorite Pokémon type (e.g. Bug, Grass)|
| badge_count            | INT    | Number of badges earned                |
| achievement_level      | STRING | Level: Beginner / Intermediate / etc.  |

📘 Table Reference (2) : `pokemon` 
| column            | type    | description                         |
|-------------------|---------|-------------------------------------|
| id                | INT     | Unique Pokémon ID                   |
| kor_name          | STRING  | Pokémon name in Korean              |
| eng_name          | STRING  | Pokémon name in English             |
| type1             | STRING  | Primary type (e.g. Grass, Fire)     |
| type2             | STRING  | Secondary type (nullable)           |
| total             | INT     | Total base stats                    |
| hp                | INT     | HP stat                             |
| attack            | INT     | Attack stat                         |
| defense           | INT     | Defense stat                        |
| special_attack    | INT     | Special Attack stat                 |
| special_defense   | INT     | Special Defense stat                |
| speed             | INT     | Speed stat                          |
| generation        | INT     | Generation number                   |
| is_legendary      | BOOLEAN | Whether the Pokémon is legendary    | 

📘 Table Reference (3): `trainer_pokemon`

-- | column           | type     | description                                     |
-- |------------------|----------|-------------------------------------------------|
-- | id               | INT      | Unique ID for each trainer's Pokémon entry     |
-- | trainer_id       | INT      | Foreign key referencing the trainer            |
-- | pokemon_id       | INT      | Foreign key referencing the Pokémon            |
-- | level            | INT      | Pokémon's current level                        |
-- | experience_point | INT      | Accumulated experience points                  |
-- | current_health   | INT      | Pokémon's current HP                           |
-- | catch_date       | DATE     | The date the Pokémon was caught                |
-- | catch_datetime   | DATETIME | Full timestamp of when the Pokémon was caught  |
-- | location         | STRING   | Location where the Pokémon was caught          |
-- | status           | STRING   | Status of the Pokémon (e.g., Active, Inactive) |*/


--------------------------------------------------------------------------------------------------------------------------


📄 Questions

  
/*Based on the trainer's Pokémon catch date (catch_date), 
calculate the number of Pokémon caught in January 2023. */

  
-- Step 1: Data validation — Check whether catch_date and catch_datetime are in the same time zone.

SELECT
  *
FROM (
SELECT 
  id,
  catch_date, 
  DATE(DATETIME(catch_datetime, "Asia/Seoul")) AS catch_datetime_kr_date
FROM `Basic.trainer_pokemon`)
WHERE catch_date != catch_datetime_kr_date 

  
-- Step 2: Calculate the number of Pokémon caught in January 2023.
SELECT
  COUNT (DISTINT id) as cnt_pokemon
FROM `Basic.trainer_pokemon`
WHERE 
  EXTRACT (YEAR FROM DATETIME(catch_datetime, "Asia/Seoul")) = 2023 
  AND EXTRACT (MONTH FROM DATETIME(catch_datetime, "Asia/Seoul")) = 1


--------------------------------------------------------------------------------------------------------------------------


/*Based on the battle time (battle_datetime), 
calculate the number of battles that occurred between 6:00 AM and 6:00 PM. */


SELECT
  COUNT (DISTINCT id) AS cnt_battle
FROM `Basic.battle`
WHERE 
  EXTRACT (HOUR FROM DATETIME(battle_timestamp, "Asia/Seoul")) BETWEEN 6 AND 18 


--------------------------------------------------------------------------------------------------------------------------


/* For each trainer, find the first day they caught a Pokémon using catch_datetime
(since catch_date is of type DATE) and output that date in the DD/MM/YYYY format.*/


SELECT 
  trainer_id, 
  FORMAT_DATETIME('%d/%m/%Y', min_catch_datetime) AS initial_date
FROM(
  SELECT
    trainer_id, 
    MIN(catch_datetime) AS min_catch_datetime
  FROM `Basic.trainer_pokemon`
  GROUP BY   
    trainer_id
  )
ORDER BY
  trainer_id


--------------------------------------------------------------------------------------------------------------------------


/* Sort trainers in descending order by the interval between the first and last day they caught a Pokémon, 
using catch_datetime and converting from UTC to Korea Standard Time (KST).*/


SELECT
  trainer_id, 
  catch_date_min, 
  catch_date_max,
  DATETIME_DIFF(catch_date_max, catch_date_min, DAY) AS day_gap
FROM (
  SELECT
    trainer_id, 
    MIN(DATETIME(catch_datetime, 'Asia/Seoul')) AS catch_date_min, 
    MAX(DATETIME(catch_datetime, 'Asia/Seoul')) AS catch_date_max, 
  FROM `Basic.trainer_pokemon`
  GROUP BY 
    trainer_id 
  )
ORDER BY 
  day_gap DESC 









