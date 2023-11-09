-- Dimas Wahyu Saputro
-- Dibimbing
-- don't forget to run the prereq query (look at Essay 2)

-- SATU
-- Create dimension tables
CREATE TABLE dim_user (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE dim_post (
    post_id INT PRIMARY KEY,
    post_text VARCHAR(500),
    post_date DATE,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id)
);

CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY
);

-- DUA
-- Populate dimension tables from raw data
INSERT INTO dim_user (user_id, user_name, country)
SELECT DISTINCT user_id, user_name, country
FROM raw_users;

INSERT INTO dim_post (post_id, post_text, post_date, user_id)
SELECT DISTINCT post_id, post_text, post_date, user_id
FROM raw_posts;

INSERT INTO dim_date (date_id)
SELECT DISTINCT post_date
FROM raw_posts;

-- TIGA EMPAT
CREATE TABLE fact_post_performance (
    date_id DATE,
    post_id INT,
    views INT,
    likes INT,
    PRIMARY KEY (date_id, post_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (post_id) REFERENCES dim_post(post_id)
);

INSERT INTO fact_post_performance (date_id, post_id, views, likes)
SELECT r.post_date, r.post_id, COUNT(DISTINCT r.user_id) AS views, COUNT(l.like_id) AS likes
FROM raw_posts r
LEFT JOIN raw_likes l ON r.post_id = l.post_id
GROUP BY r.post_date, r.post_id;

-- LIMA ENAM
CREATE TABLE fact_daily_posts (
    date_id DATE,
    user_id INT,
    num_posts INT,
    PRIMARY KEY (date_id, user_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id)
);

INSERT INTO fact_daily_posts (date_id, user_id, num_posts)
SELECT r.post_date, r.user_id, COUNT(r.post_id) AS num_posts
FROM raw_posts r
GROUP BY r.post_date, r.user_id;
