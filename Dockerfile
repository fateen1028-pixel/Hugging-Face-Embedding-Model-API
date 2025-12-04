FROM python:3.11-slim

# Create a non-root user
RUN useradd -m myuser

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Switch to non-root user BEFORE installing packages
USER myuser

# Install dependencies (this will now be installed in user's home)
RUN pip install --no-cache-dir -r requirements.txt --user

# Copy the rest of the app
COPY . .

# Expose the port
EXPOSE 5000

# Use the user-level bin path for Python
ENV PATH=/home/myuser/.local/bin:$PATH

# Run the app
CMD ["python", "app.py"]
