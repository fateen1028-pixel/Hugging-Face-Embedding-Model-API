FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements before installing
COPY requirements.txt .

# Install Python packages globally (much safer on Render)
RUN pip install --no-cache-dir -r requirements.txt

# Pre-download the embedding model during build (critical!)
RUN python - <<EOF
from sentence_transformers import SentenceTransformer
SentenceTransformer("all-MiniLM-L6-v2")
EOF

# Copy the application
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
