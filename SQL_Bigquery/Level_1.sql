# Level 1 – Basic SQL Queries

## 📘 Table Reference: `trainer`

| column                 | type   | description                            |
|------------------------|--------|----------------------------------------|
| id                     | INT    | Unique trainer ID                      |
| name                   | STRING | Trainer name                           |
| age                    | INT    | Trainer's age                          |
| hometown               | STRING | City the trainer is from               |
| preferred_pokemon_type | STRING | Favorite Pokémon type (e.g. Bug, Grass)|
| badge_count            | INT    | Number of badges earned                |
| achievement_level      | STRING | Level: Beginner / Intermediate / etc.  |

----------------------------------------------------------------------------

## 🟡 Question 1
1. Write an SQL query to display all data from the trainer table. 

```sql
SELECT *
FROM `Basic.trainer`;



