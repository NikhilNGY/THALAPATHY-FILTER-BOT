#!/bin/bash
set -e  # stop on error

# Clone repo (main or custom)
if [ -z "$UPSTREAM_REPO" ]; then
  echo "📥 Cloning main repository..."
  git clone https://github.com/NikhilNGY/THALAPATHY-FILTER-BOT.git /THALAPATHY-FILTER-BOT
else
  echo "📥 Cloning custom repository from $UPSTREAM_REPO..."
  git clone "$UPSTREAM_REPO" /THALAPATHY-FILTER-BOT
fi

cd /THALAPATHY-FILTER-BOT

# Install dependencies
echo "📦 Installing Python requirements..."
pip3 install --no-cache-dir -U -r requirements.txt

# Start the bot
echo "🚀 Starting Bot..."
exec python3 bot.py
