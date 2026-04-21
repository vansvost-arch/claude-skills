#!/bin/bash

# SSH Connection Script for Remote Servers
# Usage:
#   ./connect.sh              - Interactive shell
#   ./connect.sh "command"    - Run command and exit
#
# Configuration:
#   - Claude Code (local): use config/.env file
#   - Cloud Runtime: set environment variables directly

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config"
ENV_FILE="$CONFIG_DIR/.env"

# Load .env file if exists and variables not already set (local mode)
if [ -f "$ENV_FILE" ] && [ -z "$SSH_HOST" ]; then
    source "$ENV_FILE"
fi

# Validate required variables
if [ -z "$SSH_HOST" ] || [ -z "$SSH_USER" ]; then
    echo "Error: Missing required variables"
    echo "Required: SSH_HOST, SSH_USER"
    echo "Auth: SSH_KEY_PATH (key) or SSH_PASSWORD (password)"
    exit 1
fi

# Build command prefix (cd to project dir if specified)
if [ -n "$SERVER_PROJECT_PATH" ]; then
    CD_CMD="cd $SERVER_PROJECT_PATH &&"
else
    CD_CMD=""
fi

# Choose auth method
if [ -n "$SSH_PASSWORD" ]; then
    # Password-based auth via sshpass
    if ! command -v sshpass &>/dev/null; then
        echo "Error: sshpass not installed. Run: brew install sshpass"
        exit 1
    fi
    export SSHPASS="$SSH_PASSWORD"
    SSH_CMD="sshpass -e ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10"
else
    # Key-based auth
    if [ -z "$SSH_KEY_PATH" ]; then
        echo "Error: set SSH_KEY_PATH or SSH_PASSWORD"
        exit 1
    fi
    # Start ssh-agent if not running
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null 2>&1
    fi
    # Add key to agent
    if ! ssh-add -l 2>/dev/null | grep -q "$SSH_KEY_PATH"; then
        if [ -n "$SSH_KEY_PASSWORD" ]; then
            expect -c "
                spawn ssh-add $SSH_KEY_PATH
                expect \"Enter passphrase\"
                send \"$SSH_KEY_PASSWORD\r\"
                expect eof
            " > /dev/null 2>&1
        else
            ssh-add "$SSH_KEY_PATH" 2>/dev/null
        fi
    fi
    SSH_CMD="ssh -A"
fi

if [ -n "$1" ]; then
    $SSH_CMD "$SSH_USER@$SSH_HOST" "$CD_CMD $*"
else
    if [ -n "$CD_CMD" ]; then
        $SSH_CMD -t "$SSH_USER@$SSH_HOST" "$CD_CMD exec \$SHELL -l"
    else
        $SSH_CMD -t "$SSH_USER@$SSH_HOST"
    fi
fi
