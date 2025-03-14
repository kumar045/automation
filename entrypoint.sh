#!/bin/bash
set -e

# Clean up any existing X lock files
rm -f /tmp/.X99-lock

# Start Xvfb with optimized settings
Xvfb :99 -ac -screen 0 1920x1080x24 -nolisten tcp +extension RANDR +extension GLX +render -noreset &
sleep 3

# Start your application
exec "$@"
