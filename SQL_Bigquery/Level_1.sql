-- # Level 1 – Basic SQL Queries
-- Skills used : SELECT, FROM, WHERE, 

CREATE, UPDATE, SELECT, CTE, JOINS, OREDR BY, GROUP BY

-- 📘 Table Reference: `trainer`
-- 
-- | column                 | type   | description                            |
-- |------------------------|--------|----------------------------------------|
-- | id                     | INT    | Unique trainer ID                      |
-- | name                   | STRING | Trainer name                           |
-- | age                    | INT    | Trainer's age                          |
-- | hometown               | STRING | City the trainer is from               |
-- | preferred_pokemon_type | STRING | Favorite Pokémon type (e.g. Bug, Grass)|
-- | badge_count            | INT    | Number of badges earned                |
-- | achievement_level      | STRING | Level: Beginner / Intermediate / etc.  |

/* ------------------------------------------------------------------ */

-- 🟡 Questions
-- 1. Display all data from the trainer table.

SELECT *
FROM `Basic.trainer`

-- 2. Display the names and age of all trainers.
SELECT 
  name,
  age
FROM 'Basic.trainer'

-- 3. Display the name, age, and hometown of the trainer whose id is 3.
SELECT
  name,
  age,
  hometown
FROM 'Basic.trainer'
WHERE 
  id = 3









