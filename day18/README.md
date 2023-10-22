# OpenAQ API ETL Pipeline Project

## Project Summary
This project is an ETL pipeline project that is used to extract data from the OpenAQ API, transform the data, and load the data into a  psql database. 
```
- Ingest data from the OpenAQ API (https://docs.openaq.org/docs) to retrieve data on the current air quality around the world.
- Transform the data to filter only data from Jakarta,Indonesia
- Transform it to a format that can be stored in a database table.
- Create a PostgreSQL connection that can be used to ingest data into a database.
- Store the transformed data into a new database table.
- Schedule the DAG to run daily at 4am.
```

## Tech Stack
- Docker
- Airflow
- PostgreSQL

## How to Run
Run this project using `docker compose up` command in the root directory of this project.

## DAGs
[![Screen-Shot-2023-10-22-at-17-15-40.png](https://i.postimg.cc/c4cDmmqC/Screen-Shot-2023-10-22-at-17-15-40.png)](https://postimg.cc/4mmb4pxR)

## Additional Configuration in Airflow
### Connections
#### day18_kel11
Used to save data to the database psql production
```
Connection Id = day18_kel11
Connection Type = Postgres
Host = ep-falling-leaf-21500535.ap-southeast-1.aws.neon.tech
Schema = kel11
Login = diwahsap
Password = Yj7lGFtyH3sQ
Port = 5432
```
#### postgresql_db
Used to connect to the database older data
```
Sama as above, but change the schema to dibimbing
```
### Variables
#### endpoint_latest_data_id
Endpoint for latest data in openaq api for indonesia
```
key = endpoint_latest_data_id
val = https://api.openaq.org/v2/latest?limit=100&page=1&offset=0&sort=desc&radius=1000&country_id=23&order_by=lastUpdated&dump_raw=false
```
