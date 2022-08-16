-- Задание 1

SELECT count(*)
FROM tickets; -- 829071

SELECT count(*)
FROM tickets
WHERE passenger_name LIKE '% %'; -- 829071

SELECT count(*)
FROM tickets
WHERE passenger_name LIKE '% % %'; -- 0

SELECT count(*)
FROM tickets
WHERE passenger_name LIKE '% %%';
-- 829071

-- Задание 2

SELECT passenger_name
FROM tickets
WHERE passenger_name LIKE '___ %';

SELECT passenger_name
FROM tickets
WHERE passenger_name LIKE '% _____';

-- Задание 3
-- -- https://postgrespro.ru/docs/postgrespro/9.5/functions-matching#functions-similarto-regexp
-- -- regexp
SELECT passenger_name
FROM tickets
WHERE passenger_name SIMILAR TO '% (A|B)%' -- фамилия начинается с А или В
GROUP BY passenger_name;


-- Задание 4

SELECT passenger_name
FROM tickets
WHERE passenger_name IS NOT NULL;

-- Задание 5

SELECT CASE
           WHEN passenger_name LIKE 'A%' THEN 1
           WHEN passenger_name LIKE 'V%' THEN 2
           ELSE 0
           END
FROM tickets
ORDER BY passenger_name ASC;

SELECT COALESCE(passenger_name, passenger_id, 'unknown')
FROM tickets;

SELECT NULLIF(passenger_id, passenger_id)
FROM tickets;

SELECT GREATEST(1, 2, 3, 4, 5), LEAST(1, 2, 3, 4, 5);

-- Задание 6

SELECT r.flight_no, r.departure_airport, r.arrival_airport, a.model
FROM routes AS r
         RIGHT JOIN aircrafts AS a ON r.aircraft_code = a.aircraft_code;

-- Задание 7

SELECT DISTINCT GREATEST(departure_city, arrival_city), LEAST(departure_city, arrival_city)
FROM routes AS r
         JOIN aircrafts AS a ON r.aircraft_code = a.aircraft_code
WHERE a.model = 'Боинг 777-300'
ORDER BY 1;

SELECT DISTINCT departure_city, arrival_city
FROM routes AS r
         JOIN aircrafts AS a on r.aircraft_code = a.aircraft_code
WHERE a.model = 'Боинг 777-300'
  AND departure_city > arrival_city
ORDER BY 1;

-- Задание 8

SELECT r.flight_no, r.departure_airport, r.arrival_airport, a.model
FROM routes AS r
         FULL JOIN aircrafts AS a ON r.aircraft_code = a.aircraft_code
WHERE r.flight_no IS NULL
   OR a.model IS NULL;

-- Задание 9

SELECT departure_city, arrival_city, count(*)
FROM routes
WHERE departure_city = 'Москва'
  AND arrival_city = 'Санкт-Петербург'
GROUP BY departure_city, arrival_city;

-- Задание 10

SELECT departure_city, count(*) AS count, count(DISTINCT arrival_city) AS count_routes
FROM routes
GROUP BY departure_city
ORDER BY count DESC;

-- Задание 11

SELECT departure_city, arrival_city, count(arrival_city) AS count
FROM routes
WHERE departure_city = 'Москва'
  and array_length(days_of_week, 1) = 7
GROUP BY departure_city, arrival_city
ORDER BY count DESC;

-- Задание 12

-- -- unnest ( anyarray ) → setof anyelement
-- -- -- Разворачивает массив в набор строк.
-- -- -- Элементы массива прочитываются в порядке хранения.
SELECT unnest(days_of_week) AS day_of_week, count(*) AS num_flights
FROM routes
WHERE departure_city = 'Москва'
GROUP BY day_of_week
ORDER BY day_of_week;

-- -- вместо цифр дня недели - имена дня недели
SELECT dw.name_of_day AS day_of_week, count(*) AS num_flights
FROM (SELECT unnest(days_of_week) AS num_of_day
      FROM routes AS r
      WHERE departure_city = 'Москва') AS r,
     unnest(
             '{1, 2, 3, 4, 5, 6, 7}'::integer[],
             '{"Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"}'::text[]
         ) AS dw(num_of_day, name_of_day)
WHERE r.num_of_day = dw.num_of_day
GROUP BY day_of_week
ORDER BY day_of_week;

-- -- вместо цифр дня недели - имена дня недели (упрощенная версия (но не совсем..)
SELECT dw.name_of_day AS day_of_week, count(*) AS num_flights
FROM (SELECT unnest(days_of_week) AS num_of_day
      FROM routes AS r
      WHERE departure_city = 'Москва') AS r,
     (SELECT *
      FROM unnest('{"Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"}'::text[])
               WITH ORDINALITY AS dw(name_of_day, num_of_day)) as dw
WHERE r.num_of_day = dw.num_of_day
GROUP BY day_of_week
ORDER BY day_of_week;

-- Задание 13

-- -- минимальные и максимальные цены билетов по направлениям
SELECT f.departure_city, f.arrival_city, max(tf.amount), min(tf.amount)
FROM flights_v AS f
         LEFT JOIN ticket_flights AS tf ON f.flight_id = tf.flight_id
GROUP BY 1, 2
ORDER BY 1, 2;

-- Задание 14

-- -- частотность имен
SELECT left(passenger_name, strpos(passenger_name, ' ') - 1) AS firstname, count(*)
FROM tickets
GROUP BY 1
ORDER BY 2 DESC;

-- -- частотность фамилий
SELECT right(passenger_name, strpos(passenger_name, ' ') - 1) AS firstname, count(*)
FROM tickets
GROUP BY 1
ORDER BY 2 DESC;

-- Задание 15

-- -- применение олконнных функций

SELECT count(*) OVER (PARTITION BY flight_no), departure_airport, arrival_airport
FROM flights;

-- Задание 16

-- -- Применение FILTER
SELECT count(*) FILTER (WHERE range > 5000) AS filter_count,
       count(*)                             AS no_filter_count
FROM aircrafts;

-- Задание 17

-- -- Подсчет количества мест разной категории для каждой модели самолета
SELECT a.aircraft_code, a.model, s.fare_conditions, count(*)
FROM aircrafts AS a
         JOIN seats AS s ON a.aircraft_code = s.aircraft_code
GROUP BY a.aircraft_code, a.model, s.fare_conditions
ORDER BY a.model, fare_conditions;

-- Задание 18

SELECT a.aircraft_code                                                             AS a_code,
       a.model,
       r.aircraft_code                                                             AS r_code,
       count(*)                                                                    AS num_routes,
       (count(*)::double precision / (SELECT count(*) FROM routes))::numeric(5, 3) AS frac
FROM routes AS r
         JOIN aircrafts AS a on r.aircraft_code = a.aircraft_code
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

-- Задание 19

WITH RECURSIVE ranges (min_sum, max_sum)
                   AS (VALUES (0, 100050),
                              (100000, 200060),
                              (200000, 300070)
                       UNION ALL
                       SELECT min_sum + 100000, max_sum + 100000
                       FROM ranges
                       WHERE max_sum < (SELECT max(total_amount) FROM bookings))
SELECT *
FROM ranges;

-- -- с количеством итераций
WITH RECURSIVE ranges (min_sum, max_sum, iteration)
                   AS (VALUES (0, 100000, 0),
                              (100000, 200000, 0),
                              (200000, 300000, 0)
                       UNION ALL
                       SELECT min_sum + 100000, max_sum + 100000, iteration + 1
                       FROM ranges
                       WHERE max_sum < (SELECT max(total_amount) FROM bookings))
SELECT *
FROM ranges;

-- -- с UNION вместо UNION ALL (удаляет все дубликаты)
WITH RECURSIVE ranges (min_sum, max_sum)
                   AS (VALUES (0, 100000),
                              (100000, 200000),
                              (200000, 300000)
                       UNION
                       SELECT min_sum + 100000, max_sum + 100000
                       FROM ranges
                       WHERE max_sum < (SELECT max(total_amount) FROM bookings))
SELECT *
FROM ranges;