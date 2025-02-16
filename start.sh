#!/bin/sh

# Check if the email argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <email>"
  exit 1
fi

EMAIL=$1

# Run datagen.py with the email argument
python3 datagen.py "$EMAIL"

# Run app.py
uv run app.py &

# Capture the PID of the background process
APP_PID=$!

# Wait for app.py to start (you might need to adjust the sleep time)
sleep 5

# Run evaluate.py with the email argument
python3 evaluate.py 

# Optionally, wait for the app.py process to finish
wait $APP_PID