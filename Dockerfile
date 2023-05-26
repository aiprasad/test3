# Use a base image that includes both Python and Nginx
FROM tiangolo/uwsgi-nginx-flask:python3.9

# Specify the platform
ARG TARGETPLATFORM=linux/arm64/v8


# Set a directory for the application
WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt ./

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Install any dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container
COPY . .

# Expose the desired port
EXPOSE 5000

# Set the command to start the uWSGI server
# CMD ["uwsgi", "--ini", "uwsgi.ini"]
CMD ["uwsgi", "--ini", "uwsgi.ini", "--uid", "uwsgi"]

