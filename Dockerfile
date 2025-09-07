FROM python:3.10.8-slim-bullseye

# Install system packages
RUN apt update && apt upgrade -y \
    && apt install -y git bash dos2unix curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python deps
COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -U pip \
    && pip3 install --no-cache-dir -r /requirements.txt

# Create app directory
RUN mkdir /THALAPATHY-FILTER-BOT
WORKDIR /THALAPATHY-FILTER-BOT

# Copy entry script and fix line endings
COPY start.sh /start.sh
RUN dos2unix /start.sh && chmod +x /start.sh

# Healthcheck: check if Python is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD pgrep -f "python3 bot.py" > /dev/null || exit 1

# Default start command
CMD ["/bin/bash", "/start.sh"]
