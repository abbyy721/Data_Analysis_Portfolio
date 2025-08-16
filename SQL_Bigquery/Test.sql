/* Calculate the average level of Pokémon owned by each trainer, 
and output the name, number of Pokémon owned, and average level of 
the top 3 trainers with the highest average level. */


SELECT
  t.name,
  ROUND (AVG (tp.level),2) AS avg_level,
  COUNT (tp.id) AS cnt_pokemon,
FROM `Basic.trainer_pokemon` AS tp
LEFT JOIN `Basic.trainer` AS t
ON tp.trainer_id = t.id
WHERE tp.status != "Released"
GROUP BY t.name
ORDER BY avg_level DESC
LIMIT 3


--------------------------------------------------------------------------------------------------------------------------

  
/* For each Pokémon type1, output the type1, Pokémon name, 
and capture count of the most frequently captured Pokémon 
(regardless of release status). */ 


SELECT
  kor_name,
  type1,
  COUNT (tp.id) AS cnt_pokemon
FROM `Basic.trainer_pokemon` AS tp 
LEFT JOIN `Basic.Pokemon` AS p 
ON tp.pokemon_id = p.id 
GROUP BY kor_name, type1
ORDER BY cnt_pokemon DESC
LIMIT 3


--------------------------------------------------------------------------------------------------------------------------

  
/* How many legendary and normal Pokémon do trainers who own 
at least one legendary Pokémon have? (Also output the trainer’s name.) */


SELECT
  tp.trainer_id,
  t.name,
  COUNTIF (p.is_legendary = true) AS legendary_cnt,
  COUNTif (p.is_legendary != true) AS normal_cnt,
FROM `Basic.trainer_pokemon` as tp
LEFT JOIN `Basic.Pokemon` as p
ON p.id = tp.pokemon_id
LEFT JOIN `Basic.trainer`as t
ON tp.trainer_id = t.id
WHERE tp.status IN ("Active", "Training")
GROUP BY tp.trainer_id, t.name
HAVING legendary_cnt != 0


--------------------------------------------------------------------------------------------------------------------------

  
/* Output the trainer ID, trainer name, number of wins, number of Pokémon owned, 
and the average Pokémon level for the trainer with the most wins. 
Round the average level to two decimal places. */


WITH winner_trainer AS (
SELECT
  winner_id,
  COUNT (distinct id) as cnt_wins
FROM `Basic.Battle` 
WHERE winner_id IS NOT NULL
GROUP BY winner_id), 

pokemon_cnt_level AS (
SELECT 
  trainer_id,
  COUNT (id) as pokemon_cnt,
  ROUND (AVG (level),2) as pokemon_level
FROM `Basic.trainer_pokemon` 
WHERE status IN ("Active", "Training")
GROUP BY trainer_id)

SELECT
  winner_id, 
  name,
  cnt_wins,
  pokemon_cnt,
  pokemon_level
FROM winner_trainer as w
LEFT JOIN pokemon_cnt_level as pcl 
ON w.winner_id = pcl.trainer_id 
LEFT JOIN `Basic.trainer` as t
ON pcl.trainer_id = t.id


--------------------------------------------------------------------------------------------------------------------------


/* Calculate the total attack and defense of all Pokémon caught by each trainer, 
and find the trainer with the highest combined total.*/


SELECT
  trainer_id,
  t.name,
  SUM (attack + defense) AS sum_attack_defense
FROM `Basic.trainer_pokemon` AS tp 
LEFT JOIN `Basic.Pokemon` AS p 
ON tp.pokemon_id = p.id
LEFT JOIN `Basic.trainer` AS t
ON tp.trainer_id = t.id
GROUP BY trainer_id, t.name
ORDER BY sum_attack_defense DESC
LIMIT 3


--------------------------------------------------------------------------------------------------------------------------


/* Calculate each Pokémon’s maximum and minimum level, 
then output the name of the Pokémon with the largest level difference. */

  
WITH diff_table AS (
SELECT
  pokemon_id,
  max_level - min_level AS diff_level
FROM (
  SELECT
    pokemon_id,
    MAX (level) AS max_level, 
    MIN (level) AS min_level, 
  FROM  `Basic.trainer_pokemon`
  GROUP BY pokemon_id)
ORDER BY diff_level DESC
LIMIT 1)

SELECT
  kor_name,
  pokemon_id,
  d.diff_level
FROM diff_table AS d
LEFT JOIN `Basic.Pokemon` AS p 
ON d.pokemon_id = p.id


--------------------------------------------------------------------------------------------------------------------------


/* For each trainer, calculate the number of Pokémon they own with attack ≥ 100 and 
the number with attack < 100. Output the trainer’s name along with both counts. */


SELECT
  trainer_id,
  name,
  COUNTIF (attack >= 100) AS pokemon_cnt_above100, 
  COUNTIF (attack < 100) AS pokemon_cnt_below100
FROM `Basic.trainer_pokemon` AS tp 
LEFT JOIN `Basic.Pokemon` AS p 
ON tp.pokemon_id = p.id 
LEFT JOIN `Basic.trainer` AS t
ON tp.trainer_id = t.id
WHERE tp.status IN ("Active", "Training")
GROUP BY trainer_id, name


--------------------------------------------------------------------------------------------------------------------------





