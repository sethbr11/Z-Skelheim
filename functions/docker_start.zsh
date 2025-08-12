#!/bin/zsh

# Start Docker if it isn't running
function docker_start() {
    local HIDE_DOCKER=false

    # Check if the -h flag was passed to hide Docker Desktop
    if [[ "$1" == "-h" ]]; then
        HIDE_DOCKER=true
    fi

    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker first."
        return 1
    fi

    if ! pgrep -f "Docker" > /dev/null; then
        echo "> Starting Docker..."
        open -a Docker
        while ! docker info > /dev/null 2>&1; do
            echo "> Waiting for Docker to start..."
            sleep 1
        done

        # Minimize Docker Desktop
        if [[ "$HIDE_DOCKER" == true ]]; then
            echo "> Hiding Docker Desktop..."
            osascript -e 'tell application "System Events" to keystroke "h" using {command down}'
        fi
    fi
}