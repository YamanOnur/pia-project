#!/bin/bash

# Start the gRPC server in the background
python query_server.py &

# Start the Flask app using Gunicorn
gunicorn --bind 0.0.0.0:5000 app:app
