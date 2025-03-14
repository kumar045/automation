FROM mcr.microsoft.com/playwright/python:v1.33.0-jammy

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and browsers
RUN playwright install

# Copy application code
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run FastAPI with xvfb-run to simulate an X server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
