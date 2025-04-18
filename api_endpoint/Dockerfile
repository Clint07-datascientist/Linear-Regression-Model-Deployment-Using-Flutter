FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install core dependencies first
RUN pip install --no-cache-dir numpy==1.23.5 && \
    pip install --no-cache-dir scipy==1.10.1 && \
    pip install --no-cache-dir scikit-learn==1.6.1 && \
    pip install --no-cache-dir pandas==1.5.3

# Install other Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create ml_model directory if it doesn't exist
RUN mkdir -p ml_model

# Expose the port
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] 