FROM python:3.12-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Install FastAPI and Uvicorn
#RUN pip install fastapi uvicorn 

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin:$PATH"

# Set up the application directory
WORKDIR /app


# Copy requirements.txt first to leverage Docker layer caching
COPY requirements.txt /app/requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt
# Copy application files
COPY . /app

# Explicitly set the correct binary path and use `sh -c`
##
#
#CMD ["uv", "run", "app.py"]
# Make the script executable
RUN chmod +x /app/start.sh

# Run the start script
CMD ["/app/start.sh"]
