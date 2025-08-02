/* 

🔹 Level 1 – Basic SQL Queries
🔸 Skills used : SELECT, FROM, WHERE, GROUP BY, ORDER BY



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
| is_legendary      | BOOLEAN | Whether the Pokémon is legendary    | */



📄 Questions

/* Display all data from the trainer table. */

  
SELECT *
FROM `Basic.trainer`


--------------------------------------------------------------------------------------------------------------------------

  
/* Display the names and age of all trainers. */

  
SELECT 
  name,
  age
FROM Basic.trainer

  
--------------------------------------------------------------------------------------------------------------------------

  
/* Display the name, age, and hometown of the trainer whose id is 3. */

  
SELECT
  name,
  age,
  hometown
FROM Basic.trainer
WHERE 
  id = 3


--------------------------------------------------------------------------------------------------------------------------

  
/* Count the number of Pokémon in the pokemon table. */

  
SELECT
  COUNT (id) AS Total_pokemon
FROM Basic.pokemon

  
--------------------------------------------------------------------------------------------------------------------------

  
/* How many pokemon exist per generation. */

  
SELECT
  generation, 
  COUNT(id) AS Pokemon_count
FROM Basic.pokemon
GROUP BY generation
ORDER BY generation


--------------------------------------------------------------------------------------------------------------------------

  
/* 6. Group Pokemon by Type1, count how many belong to each type, 
  filter to show only types with 10 or more Pokemon, 
  and sort the result in descending order of count. */

  
SELECT
  type1, 
  COUNT (*) AS cnt_pokemon
FROM Basic.pokemon
GROUP BY 
  type1
HAVING cnt_pokemon >= 10 
ORDER BY 
  cnt_pokemon DESC 


--------------------------------------------------------------------------------------------------------------------------

  
/* Count how many Pokemon do not have a type 2. */

  
SELECT
  COUNT (*) AS cnt_no_type2
FROM Basic.pokemon
WHERE 
  type2 IS NULL  


--------------------------------------------------------------------------------------------------------------------------


/* Among Pokemon that do not have type 2, 
  group them by type 1 and count how many belong to each type. 
  sort the results by the number of Pokemon in descending order. */

SELECT 
  type1,
  COUNT(id) AS cnt_type1
FROM Basic.pokemon
WHERE
  type2 IS NULL 
GROUP BY 
  type1
ORDER BY 
  cnt_type1 DESC


--------------------------------------------------------------------------------------------------------------------------


/* Count the number of Pokemon based on whether they are legendary or not. */


SELECT
  is_legendary,
  COUNT(id) AS cnt_pokemon
FROM Basic.pokemon
GROUP BY 
  is_legendary
ORDER BY 
  is_legendary DESC 











