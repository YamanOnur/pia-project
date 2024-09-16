# Use the official MySQL 8.0 image
FROM mysql:8.0

# Set environment variable for MySQL root password
ENV MYSQL_ROOT_PASSWORD=rootpassword

# Copy the initialization SQL script into the Docker image
COPY init.sql /docker-entrypoint-initdb.d/

# Run MySQL server
CMD ["mysqld"]
