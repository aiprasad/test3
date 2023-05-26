# Use a base image that includes both Python and Nginx
FROM python:3.9

# Set a directory for the application
WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt ./

# Install any dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container
COPY . .

EXPOSE 80

# Start the app
CMD ["gunicorn", "-b", "0.0.0.0:80","app:app","--workers","1","-k","uvicorn.workers.UvicornWorker"]

