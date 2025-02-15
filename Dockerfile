# Use the official Python 3.11 slim image
FROM python:3.11

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Install FastAPI and Uvicorn
RUN pip install fastapi uvicorn

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin:$PATH"


# Set up the application directory
WORKDIR /app

# Copy application files
COPY . /app

# Run the application using uv
CMD ["uv", "run", "app.py"]