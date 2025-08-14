/* 

🔹 Level 2 – Advanced SQL Queries
🔸 Skills used : CASE/WHEN, IF

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


/* Change the type of Pokémon whose type1 or type2 is "Rock" or "Ground" to "Rock & Ground",
and keep the others as they are, creating a new column called new_type. 
Then, output the number of Pokémon species corresponding to each new_type. */


SELECT 
  New_type, 
  COUNT(DISTINCT id) AS cnt_newtype 
FROM ( 
SELECT
  *,
  CASE 
    WHEN (type1 IN ("Rock", "Ground")) OR (type2 IN ("Rock", "Ground")) 
    THEN "Rock&Ground" ELSE type1
  END AS New_type
FROM `Basic.Pokemon`)
GROUP BY New_type


--------------------------------------------------------------------------------------------------------------------------


/* Create a new column called speed_category that displays "Fast" 
if a Pokémon’s speed is 70 or higher, and "Slow" otherwise. */


SELECT
  *,
  IF (speed >= 70, "Fast", "Slow") AS speed_category
FROM `Basic.Pokemon`


--------------------------------------------------------------------------------------------------------------------------

  
/* Create a new column called type_korean that classifies Pokémon according to their type1 as follows:
"Water" → "물"
"Fire" → "불" 
"Electric" → "전기"
And all other types → "기타" */


SELECT
  id,
  Kor_name,
  type1,
  CASE 
    WHEN type1 = "Water" THEN "물"
    WHEN type1 = "Fire" THEN "불"
    WHEN type1 = "Electric" THEN "전기"
    ELSE "기타"
  END AS type_korean 
FROM `Basic.Pokemon`


--------------------------------------------------------------------------------------------------------------------------

  
/* Classify each Pokémon based on its total score (total) as follows:
300 or less → "Low"
301 to 500 → "Medium"
501 or more → "High"
Then, output all Pokémon whose classification is "Medium". */


SELECT
  Kor_name, 
  Total,
  category_total
FROM (
  SELECT
    Kor_name,
    total, 
    CASE
      WHEN total <= 300 THEN "Low"
      WHEN total BETWEEN 301 AND 500 THEN "Medium"
      WHEN total >= 501 THEN "High"
    END AS category_total
  FROM `Basic.Pokemon`)
WHERE category_total = "Medium"


--------------------------------------------------------------------------------------------------------------------------

  











  
