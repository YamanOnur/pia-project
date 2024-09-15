# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Install required system packages and tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    unzip \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install the specific version of `protoc` (5.28.1)
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v28.1/protoc-28.1-linux-x86_64.zip && \
    unzip protoc-28.1-linux-x86_64.zip -d /usr/local && \
    rm protoc-28.1-linux-x86_64.zip

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./ 

# Install the Python dependencies, including Gunicorn
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy the .proto file into the container
COPY query_service.proto ./ 

# Generate the gRPC code
RUN python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. query_service.proto 

# Copy the rest of the application code into the container
COPY . . 

# Copy the supervisor configuration file into the container
COPY supervisord.conf /etc/supervisor/supervisord.conf 

# Expose the ports the app runs on
EXPOSE 5000
EXPOSE 50055

# Define the command to run supervisor
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]