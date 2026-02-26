# =============================================================================
# ArcheHeisenberg Docker Image
# =============================================================================
# One-Click AI Assistant - Dockerized
# 
# Build:   docker build -t heisenberg/archehisenberg:latest .
# Run:     docker run -d -p 18789:18789 --name heisenberg heisenberg/archehisenberg
# 
# =============================================================================

# Base Image
FROM python:3.12-slim

# Labels
LABEL maintainer="Heisenberg <heisenberg@ai.local>"
LABEL description="ArcheHeisenberg - One-Click AI Assistant"
LABEL version="1.0.0"

# Environment
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV HOME=/root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI (for docker-in-docker or docker socket)
# RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*

# Create workspace
WORKDIR /workspace

# Copy project files
COPY . /workspace/

# Make scripts executable
RUN chmod +x /workspace/*.sh /workspace/*.command 2>/dev/null || true

# Install Python dependencies
RUN pip install --no-cache-dir \
    openai \
    anthropic \
    requests \
    python-dotenv \
    flask \
    websocket-client

# Expose ports
EXPOSE 18789 8080 22

# Default command
CMD ["/bin/bash"]

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:18789/health || exit 1
