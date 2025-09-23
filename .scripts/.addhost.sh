#!/bin/bash

# Define color codes
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Prompt for IP
echo -ne "${YELLOW}Insert [IP] for machine:${NC} "
read IP

# Validate IP (IPv4 only)
if ! [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] ||
  [[ $IP =~ [^0-9.] ]] ||
  [[ $(echo $IP | tr '.' '\n' | awk '{if ($1>255) exit 1}') ]]; then
  echo -e "${RED}IP is not a valid IP${NC}"
  exit 1
fi

# Prompt for name
echo -ne "${YELLOW}Insert name for [$IP]:${NC} "
read NAME

# Check for existing entries
if grep -qE "^$IP\s+$NAME(\s|$)" /etc/hosts; then
  echo -e "${RED}Machine IP and hostname already exists: $IP $NAME${NC}"
  exit 1
fi

# Add to /etc/hosts
echo "$IP $NAME" | sudo tee -a /etc/hosts >/dev/null
echo -e "${GREEN}Machine successfully added to /etc/hosts${NC}"
