
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

-- 📘 Table Reference (3): `trainer_pokemon`

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


  


LAG/LEAD
FIRST/LAST_VALUE
ROW_NUMBER
RANK/DENSE_RANK
WITH(CTE)
