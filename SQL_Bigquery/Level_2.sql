/* 

🔹 Level 2 – Advanced SQL Queries
🔸 Skills used : 
- STRING FUNCTIONS (CONCAT, SPLIT, REPLACE, TRIM, UPPER)
- DATE/TIME FUNCTIONS (TIMESTAMP, DATETIME, EXTRACT, TRUNC, PARSE, FORMAT) 



📄 STRING FUNCTIONS Practice 

SELECT
  CONCAT ("Hi", "Hello", "!") AS result_1
==> Hi Hello !

SELECT 
  SPLIT ("A, B, C, D",", ") AS result_2
==> "A", "B", "C", "D"

SELECT
  REPLACE ("Hi Hello", "Hi", "Good morning") AS result_3
==> Good morning Hello 

SELECT
  TRIM ("Hi Hello", "Hello") AS result_4
==> Hi 

SELECT
  UPPER ("abc") AS result_5
==> ABC 


  
📄 DATE/TIME FUNCTIONS Practice 

  
/*time data conversion*/

  
SELECT
  TIMESTAMP_MILLIS(1704176819711) AS milli_to_timestamp,
  TIMESTAMP_MICROS(1704176819711000) AS micro_to_timestamp,
  DATETIME(TIMESTAMP_MICROS(1704176819711000)) AS micro_to_datetime,
  DATETIME(TIMESTAMP_MICROS(1704176819711000), 'Asia/Seoul') AS micro_to_datetime_asia

  
/*Time zone application*/

  
SELECT
  CURRENT_DATE() AS current_date,
  CURRENT_DATE('America/Chicago') AS america_date,
  CURRENT_DATETIME() AS current_datetime, 
  CURRENT_DATETIME('America/Chicago') AS current_datetime_america 


/*Extract year, month, week, day, hour, munute from a DATETIME */


SELECT
  EXTRACT(YEAR FROM DATETIME "2024-01-02 14:00:00") AS year, 
  EXTRACT (MONTH FROM DATETIME "2024-01-02 14:00:00") AS month,
  EXTRACT (WEEK FROM DATETIME "2024-01-02 14:00:00") AS week, 
  EXTRACT (DAY FROM DATETIME "2024-01-02 14:00:00") AS day,
  EXTRACT (HOUR FROM DATETIME "2024-01-02 14:00:00") AS hour,
  EXTRACT (MINUTE FROM DATETIME "2024-01-02 14:00:00") AS minute

  
/*Extract the day of the week from a DATETIME value.*/

  
SELECT
  EXTRACT (DAYOFWEEK FROM DATETIME "2025-08-07 14:00:00") AS day_of_week_thu,
  EXTRACT (DAYOFWEEK FROM DATETIME "2025-08-08 14:00:00") AS day_of_week_fri,
  EXTRACT (DAYOFWEEK FROM DATETIME "2025-08-09 14:00:00") AS day_of_week_sat

  
/*Truncate a DATETIME value to day, year, month, and hour.*/


  SELECT
  DATETIME "2024-03-02 14:42:13" AS original_data, 
  DATETIME_TRUNC (DATETIME "2024-03-02 14:42:13", DAY) AS day_trunc, 
  DATETIME_TRUNC (DATETIME "2024-03-02 14:42:13", YEAR) AS year_trunc, 
  DATETIME_TRUNC (DATETIME "2024-03-02 14:42:13", MONTH) AS month_trunc, 
  DATETIME_TRUNC (DATETIME "2024-03-02 14:42:13", HOUR) AS hour_trunc, 


/*Convert a string to a DATETIME value*/ 
/*Convert a DATETIME value to the date and time representation (English)*/


SELECT
  PARSE_DATETIME('%Y-%m-%d %H:%M:%S', "2025-08-07 14:30:00") AS parse_datetime,
  FORMAT_DATETIME('%c', "2025-08-07 14:30:00") AS formatted


/*Using the given DATETIME value, find the last day of the month, 
  the last day of the week (with the default start day), 
  and the last day of the week when Sunday is considered the first day.*/

  
SELECT
  LAST_DAY(DATETIME "2025-08-07 14:30:00") AS last_day,
  LAST_DAY(DATETIME "2025-08-07 14:30:00",MONTH) AS last_day_month,
  LAST_DAY(DATETIME "2025-08-07 14:30:00",WEEK) AS last_day_week,
  LAST_DAY(DATETIME "2025-08-07 14:30:00",WEEK(SUNDAY)) AS last_day_week_sun,


/*Find the difference in days and in months between two DATETIME values.*/

  
SELECT
  DATETIME_DIFF(first_datetime, second_datetime, DAY) AS day_diff,
  DATETIME_DIFF(first_datetime, second_datetime, MONTH) AS month_diff
FROM(
  SELECT
    DATETIME "2024-04-02 10:20:00" AS first_datetime,
    DATETIME "2021-01-01 15:20:00" AS second_datetime)



