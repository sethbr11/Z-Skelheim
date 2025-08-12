#!/bin/zsh

# Start a plantuml server
function plantumlserver() {
    # Parse arguments
    local REMOVE_IMAGE=true
    local VERBOSE=false
    while [[ $# -gt 0 ]]; do
        case $1 in
            -r)
                REMOVE_IMAGE=false
                shift
                ;;
            -v)
                VERBOSE=true
                shift
                ;;
            *)
                echo "Usage: plantuml [-r] [-v]"
                echo "  -r  Do not remove Docker image on cleanup"
                echo "  -v  Enable verbose logging"
                return 1
                ;;
        esac
    done

    # Configurable vars
    PORT=8989
    IMAGE="plantuml/plantuml-server:jetty"
    CONTAINER_NAME="plantuml_server_dev"

    # Make sure docker is started
    docker_start -h

    # Check if image exists, pull if missing
    if ! docker image inspect "$IMAGE" > /dev/null 2>&1; then
        echo "> Pulling PlantUML Docker image..."
        if ! docker pull "$IMAGE" > /dev/null 2>&1; then
            echo "Failed to pull image"
            return 1
        fi
    fi

    # Function to clean up
    cleanup() {
        echo "\n> Stopping PlantUML server..."
        docker stop "$CONTAINER_NAME" >/dev/null 2>&1
        docker rm "$CONTAINER_NAME" >/dev/null 2>&1
        if [[ "$REMOVE_IMAGE" == true ]]; then
            echo "> Removing Docker image..."
            docker rmi "$IMAGE" >/dev/null 2>&1
        fi
        echo "> Cleanup complete."
    }

    # Set up trap for cleanup on interrupt
    trap 'cleanup; return 0' SIGINT

    # Start container in detached mode, mapping chosen port
    echo "> Starting PlantUML server on http://localhost:$PORT ..."
    if ! docker run --rm -d \
        --name "$CONTAINER_NAME" \
        -p $PORT:8080 \
        "$IMAGE" >/dev/null; then
        echo "Failed to start container"
        return 1
    fi

    # Wait briefly for container to start
    sleep 2

    # Verify container is running
    if ! docker ps --filter "name=$CONTAINER_NAME" --format "table {{.Names}}" | grep -q "$CONTAINER_NAME"; then
        echo "Container failed to start properly"
        cleanup
        return 1
    fi

    # Open in browser (macOS: open, Linux: xdg-open)
    if command -v open >/dev/null; then
        open "http://localhost:$PORT"
    elif command -v xdg-open >/dev/null; then
        xdg-open "http://localhost:$PORT"
    else
        echo "> Open http://localhost:$PORT in your browser."
    fi

    echo "\n -- PlantUML server is running. Press Ctrl+C to stop. --"

    # Handle verbose vs normal mode
    if [[ "$VERBOSE" == true ]]; then
        # In verbose mode, follow logs until interrupted
        docker logs -f "$CONTAINER_NAME" 2>/dev/null
    else
        # In normal mode, wait for interrupt without busy looping
        while docker ps --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; do
            sleep 1
        done
    fi

    # Cleanup and return control
    cleanup
}