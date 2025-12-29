# Agentic Design Patterns

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)

A hands-on guide to building intelligent systems using modern AI agent frameworks and design patterns. This repository contains the code examples and notebooks for **"Agentic Design Patterns" by Antonio Gulli**.

## 🚀 Quick Start with Docker

The easiest way to run the environment is using Docker. This ensures all dependencies (LangChain, CrewAI, Google ADK, OpenTelemetry) are correctly installed without version conflicts.

### 1. Prerequisites
- Docker Desktop installed
- An `.env` file with your API keys (see `.env.example`)

### 2. Build and Run
```bash
# Build the container
docker build -t agentic-patterns .

# Start the environment
docker run -p 8888:8888 --env-file .env agentic-patterns
```

Once running, open your browser to `http://localhost:8888` to access JupyterLab.

## 🛠 Project Structure

- `notebooks/`: Comprehensive collection of Jupyter notebooks (Chapters 1-21) covering:
  - Prompt Chaining & Routing
  - Parallelization & Reflection
  - Tool Use & Planning
  - Multi-Agent Collaboration
  - Memory Management & Adaptation
  - Model Context Protocol (MCP)
- `Dockerfile`: Production-ready container setup with optimized dependency resolution.
- `constraints.txt`: Strict version pinning to prevent `pip` backtracking issues, especially with OpenTelemetry/GCP packages.

## 🔧 Local Development (Without Docker)

If you prefer to run locally:

1. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
2. Install dependencies with constraints:
   ```bash
   pip install --upgrade pip setuptools wheel
   pip install -r requirements.txt -c constraints.txt
   ```

## 📝 Troubleshooting: Pip Backtracking
If you experience a "hang" during `pip install`, it is likely due to dependency resolver backtracking (common with OpenTelemetry). 
- **Solution:** Always use the `-c constraints.txt` flag during installation as shown above.
- **Diagnostics:** The Docker build is configured with `-v` (verbose) flags and final package verification to help debug these issues.

---
*Based on "Agentic Design Patterns: A Hands-On Guide to Building Intelligent Systems" by Antonio Gulli.*
