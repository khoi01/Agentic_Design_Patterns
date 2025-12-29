# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and change ownership of the workdir
RUN useradd -m jovyan
RUN chown -R jovyan:jovyan /app

# Install Python dependencies
COPY requirements.txt constraints.txt ./

# 1. Install core application dependencies first
# This helps isolate if the hang is in the core stack or observability
RUN pip install --no-cache-dir --prefer-binary \
    langchain \
    langchain-openai \
    crewai \
    google-adk \
    pydantic \
    pandas \
    jupyterlab

# 2. Install remaining dependencies with constraints
# If this hangs, we know it's the OTel resolver backtracking
RUN pip --version && \
    pip install --no-cache-dir -v --prefer-binary \
    -r requirements.txt -c constraints.txt && \
    echo "--- FINAL RESOLVED PACKAGES ---" && \
    pip freeze | grep -i opentelemetry || true

# Copy the rest of the application code
COPY --chown=jovyan:jovyan . .

# Switch to the non-root user
USER jovyan

# Expose the port JupyterLab will run on
EXPOSE 8888

# Command to run JupyterLab or Notebook
# Using 'jupyter lab' by default, but can be changed to 'jupyter notebook'
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
