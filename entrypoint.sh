#!/bin/bash
set -e

# Clean up any existing X lock files
rm -f /tmp/.X99-lock

# Start Xvfb
Xvfb :99 -ac -screen 0 1920x1080x24 -nolisten tcp &
sleep 2

# Start VNC server
x11vnc -display :99 -rfbport 5900 -listen 0.0.0.0 -N -forever -passwd secret -shared &

# Start your application
uvicorn main:app --host 0.0.0.0 --port 8000
