FROM mcr.microsoft.com/playwright/python:v1.50.0-noble

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and browsers
RUN playwright install

# Copy application code
COPY . .

# Expose ports
EXPOSE 8000 5900

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99
# Add these browser optimization environment variables
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
# Increase timeouts and disable GPU
ENV PLAYWRIGHT_BROWSER_TIMEOUT=120000
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/ms-playwright/chromium-1155/chrome-linux/chrome

# Create an entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
