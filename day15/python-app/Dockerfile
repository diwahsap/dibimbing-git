# Use the official Python image
FROM python:3.8

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of application's code
COPY . .

# Set the environment variables for database connection
ENV DB_HOST=database
ENV DB_PORT=5432
ENV DB_NAME=kel11
ENV DB_USER=kel11
ENV DB_PASSWORD=kelompok11

# Command to run your data ingestion script
CMD [ "python", "data_ingestion_script.py" ]
