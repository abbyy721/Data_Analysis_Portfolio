/* 

🔹 Level 3 – Advanced SQL Queries
🔸 Skills used : JOIN


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


/* Output the number of Pokémon (by species) currently owned by trainers, in descending order of quantity.
(Here, “currently owned” refers to Pokémon whose status is not "Released") */

  
SELECT
  kor_name,
  COUNT(DISTINCT tp.id) AS pokemon_cnt
FROM `Basic.trainer_pokemon` AS tp
LEFT JOIN `Basic.Pokemon` AS p
ON tp.pokemon_id = p.id
WHERE tp.status IN ("Active", "Released")
GROUP BY kor_name
ORDER BY pokemon_cnt DESC

  
--------------------------------------------------------------------------------------------------------------------------


/* Count the number of Grass-type Pokémon all trainers have, based on type1, 
including only those whose status is not "Released". 
Trainer information is in the trainer_pokemon table, and Pokémon information is in the pokemon table. */
  

SELECT
  type1,
  pokemon_cnt
FROM (
  SELECT
    p.type1,
    COUNT(DISTINCT tp.id) AS pokemon_cnt
  FROM `Basic.trainer_pokemon` AS tp
  LEFT JOIN `Basic.Pokemon` AS p
  ON tp.pokemon_id = p.id
  WHERE tp.status IN ("Active", "Training")
  GROUP BY p.type1)
WHERE type1 = "Grass"

  
--------------------------------------------------------------------------------------------------------------------------


/* Compare each trainer’s hometown with the location where they caught a Pokémon, 
and find the number of trainers who caught a Pokémon in their own hometown (regardless of the Pokémon’s status). 
Trainer information is in the trainer table, and catch information is in the trainer_pokemon table. */


SELECT
  COUNT (DISTINCT tp.trainer_id) AS cnt_trainer,
FROM `Basic.trainer_pokemon` AS tp
LEFT JOIN `Basic.trainer` AS t 
ON tp.trainer_id = t.id
WHERE tp.location = t.hometown

  
--------------------------------------------------------------------------------------------------------------------------


/* Which type1 of Pokémon do Master-rank trainers own the most?
(The rank information is in the trainer table, the Pokémon type1 information is in the pokemon table, 
and the ownership information is in the trainer_pokemon table.) */

SELECT
  COUNT (DISTINCT tp.id) AS pokemon_cnt,
    type1
  
  FROM  `Basic.trainer_pokemon` AS tp
    LEFT JOIN `Basic.Pokemon` AS p 
    ON tp.pokemon_id = p.id
    LEFT JOIN `Basic.trainer` AS t 
    ON tp.trainer_id = t.id
    
  WHERE status IN ("Active", "Training") And achievement_level = "Master"
GROUP BY type1
ORDER BY pokemon_cnt DESC


--------------------------------------------------------------------------------------------------------------------------


/* How many Generation 1 and Generation 2 Pokémon do trainers from Incheon own, respectively?
(The hometown information is in the trainer table, the generation information is in the pokemon table, 
and the ownership information is in the trainer_pokemon table.) */

SELECT
  p.generation,
  COUNT (DISTINCT tp.id) AS pokemon_cnt,
FROM `Basic.trainer_pokemon` AS tp
  LEFT JOIN `Basic.trainer` AS t 
  ON tp.trainer_id = t.id
  LEFT JOIN `Basic.Pokemon` AS p 
  ON tp.pokemon_id = p.id
WHERE t.hometown = "Incheon" and p.generation IN (1, 2) and tp.status != "Released"
GROUP BY p.generation






  
  


LAG/LEAD
FIRST/LAST_VALUE
ROW_NUMBER
RANK/DENSE_RANK
WITH(CTE)
