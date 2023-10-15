import pandas as pd
import requests
from sqlalchemy import create_engine
import os 

url = 'https://api.opencagedata.com/geocode/v1/json'

api_key = 'a34768ccd55d49cfa29fb5753e2d1486'

countries = ['USA', 'China', 'Russia', 'Brazil', 'France', 'Germany', 'UK',
             'Italy', 'Ukraine', 'Japan', 'Poland', 'Romania', 'Spain',
             'Argentina', 'Netherlands', 'Hungary', 'Australia',
             'South Africa', 'Belgium', 'Czech Republic']

countries_list = []
for country in countries:
    params = {'q': country, 'key': api_key}
    response = requests.get(url, params=params)

    json_data = response.json()

    components = json_data['results'][0]['components']
    geometry = json_data['results'][0]['geometry']

    country_components = {
        'country': country,
        'country_code': components.get('country_code', ''),
        'latitude': geometry.get('lat'),
        'longitude': geometry.get('lng')
    }

    countries_list.append(country_components)

component_df = pd.DataFrame(countries_list)

# Get database connection details from environment variables
host = os.getenv('DB_HOST')
port = os.getenv('DB_PORT')
database = os.getenv('DB_NAME')
username = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')

# Create database connection
engine = create_engine(f'postgresql://{username}:{password}@{host}:{port}/{database}')

# Load the DataFrame into a PostgreSQL table
component_df.to_sql(name='component_df', con=engine, if_exists='replace', index=False)

# Close the database connection
engine.dispose()
