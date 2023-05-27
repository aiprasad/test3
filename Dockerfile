#use base image offical from python
FROM python:3.9

#set directory for the application
WORKDIR /app

#system package installation and remove package list to save disk space
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

#copy the requirements file
COPY requirements.txt ./

#install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

#copy the application code
COPY . .

#xpose the required port
EXPOSE 80

#start the flask application
CMD ["python3", "app.py"]

