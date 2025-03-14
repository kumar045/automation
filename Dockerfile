FROM mcr.microsoft.com/playwright/python:v1.50.0-noble

# Install Python dependencies and VNC
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y x11vnc

# Install Playwright and browsers
RUN playwright install

# Copy application code
COPY . .

# Expose ports
EXPOSE 8000 5900

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99

# Create an entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
