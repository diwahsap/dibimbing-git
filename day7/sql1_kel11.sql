-- Kelompok 11:
-- 1. Chintya Dewi Prawitasuri
-- 2. Dhevita Intan Ervandra
-- 3. Dimas Wahyu Saputro
-- 4. Fionjufo Fahrezi
-- 5. Navi Latul Ulya

-- case 1
-- Find movie title that start with the word ‘The’
SELECT
    mov_title
FROM
    movie
WHERE
    mov_title
LIKE
    'The%';

-- case 2
-- Find movies’ title that directed by James Cameron
-- (recommended output: director name, movie title)\
SELECT
    *
FROM
    (SELECT
        concat(dir_fname, ' ', dir_lname) AS director_name,
        m.mov_title AS movie_title
    FROM
        movie_direction md
    JOIN
        director d on md.dir_id = d.dir_id
    JOIN
        movie m on md.mov_id = m.mov_id)
    AS t1
WHERE
    director_name = 'James Cameron';

-- case 3
-- List all first name of actor and director (only one column, no redundancy, and sorted alphabetically)
SELECT
    DISTINCT act_fname AS first_name
FROM
    (SELECT
        act_fname
    FROM
        actor a
    UNION
    SELECT
        dir_fname
    FROM
        director d) AS t1
ORDER BY
    first_name;

-- case 4
-- Find how many Mystery, Drama, and Adventure movies in the movie table
-- (recommended output: genre title, number of movies)
SELECT
    gen_title as genre_title,
    count(gen_id) AS number_of_movies
FROM
    (SELECT
        mg.mov_id,
        m.mov_title,
        mg.gen_id,
        g.gen_title
    FROM
        movie_genres mg
    JOIN
        genres g on mg.gen_id = g.gen_id
    JOIN
        movie m on mg.mov_id = m.mov_id) AS t1
WHERE
    gen_title IN ('Mystery', 'Drama', 'Adventure')
GROUP BY
    gen_title;

-- case 5
-- Label the duration with this rule:
--	mov_time < 100 = short movie
--	mov_time > 130 = long movie
--	mov_time between 100 and 130 = normal movie
-- Then, count the movies of each label
-- (recommended output: label duration, number of movies)
SELECT
    CASE
        WHEN mov_time < 100 THEN 'short movie'
        WHEN mov_time > 130 THEN 'long movie'
        WHEN mov_time >= 100 AND mov_time <= 130 THEN 'normal movie'
        END AS label_duration,
    COUNT(mov_id) AS number_of_movies
FROM
    movie
GROUP BY
    label_duration;