#!/bin/bash

# Obsidian TODO Search Script
# Searches for TODOs with optional tag and note filtering
# Usage: ./search-todos.sh [--tag TAG1,TAG2,...] [--note NOTE1,NOTE2,...]
unalias obsidian
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Initialize variables
TAGS=()
NOTES=()
VAULT_NAME="Ubuntu"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --tag)
      IFS=',' read -ra TAGS <<< "$2"
      shift 2
      ;;
    --note)
      IFS=',' read -ra NOTES <<< "$2"
      shift 2
      ;;
    --vault)
      VAULT_NAME="$2"
      shift 2
      ;;
    --help)
      echo "Usage: $0 [--tag TAG1,TAG2,...] [--note NOTE1,NOTE2,...] [--vault VAULT_NAME]"
      echo ""
      echo "Options:"
      echo "  --tag TAG1,TAG2,...     Filter TODOs by comma-separated tags"
      echo "  --note NOTE1,NOTE2,...  Filter TODOs in comma-separated notes"
      echo "  --vault VAULT_NAME      Specify vault name (if multiple vaults)"
      echo "  --help                  Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0                                              # All TODOs"
      echo "  $0 --tag work,robotics                         # TODOs with work or robotics tags"
      echo "  $0 --note aris sync,aris Sort                  # TODOs in specific notes"
      echo "  $0 --tag home --note projects                  # Combined filters"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if Obsidian CLI is available
if ! command -v obsidian &> /dev/null; then
  echo -e "${RED}Error: obsidian CLI not found. Please install it first.${NC}"
  exit 1
fi

# Check if Obsidian is running, if not start it
if ! pgrep -x "obsidian" > /dev/null; then
  echo -e "${YELLOW}Obsidian not running. Launching...${NC}"
  obsidian &
  sleep 2
fi

# Build the base search query for TODOs
VAULT_PARAM=""
if [ -n "$VAULT_NAME" ]; then
  VAULT_PARAM="vault=\"$VAULT_NAME\""
fi

# Search for all TODOs
echo -e "${BLUE}Searching for TODOs...${NC}\n"

# If we have tags, search for them
if [ ${#TAGS[@]} -gt 0 ]; then
  echo -e "${BLUE}Filtering by tags: ${TAGS[*]}${NC}\n"
  
  for tag in "${TAGS[@]}"; do
    # Trim whitespace
    tag=$(echo "$tag" | xargs)
    echo -e "${YELLOW}TODOs with tag: #${tag}${NC}"
    
    if [ -n "$VAULT_PARAM" ]; then
      obsidian $VAULT_PARAM search:context query="- \[ \]" | grep -i "#${tag}" | head -20
    else
      obsidian search:context query="- \[ \]" | grep -i "#${tag}" | head -20
    fi
    echo ""
  done
fi

# If we have notes, search in those specific notes
if [ ${#NOTES[@]} -gt 0 ]; then
  echo -e "${BLUE}Filtering by notes: ${NOTES[*]}${NC}\n"
  
  for note in "${NOTES[@]}"; do
    # Trim whitespace
    note=$(echo "$note" | xargs)
    echo -e "${YELLOW}TODOs in note: [[${note}]]${NC}"
    
    if [ -n "$VAULT_PARAM" ]; then
      obsidian $VAULT_PARAM search:context query="- \[ \]" path="$note" 2>/dev/null || \
      obsidian $VAULT_PARAM search:context query="- \[ \]" | grep -i "$note" | head -20
    else
      obsidian search:context query="- \[ \]" path="$note" 2>/dev/null || \
      obsidian search:context query="- \[ \]" | grep -i "$note" | head -20
    fi
    echo ""
  done
fi

# If no filters, show all TODOs
if [ ${#TAGS[@]} -eq 0 ] && [ ${#NOTES[@]} -eq 0 ]; then
  echo -e "${YELLOW}All TODOs in vault:${NC}\n"
  
  if [ -n "$VAULT_PARAM" ]; then
    obsidian $VAULT_PARAM search:context query="- \[ \]" limit=50
  else
    obsidian search:context query="- \[ \]" limit=50
  fi
fi

echo -e "\n${GREEN}Search complete!${NC}"
