#!/bin/sh

while true; do
    PODS=$(kubectl get pods)

    if [ $? -ne 0 ]; then
        echo "Error executing kubectl command. Make sure kubectl is installed and configured."
        exit 1
    fi

    all_running=true

    echo "$PODS" | tail -n +2 | while read -r LINE; do
        if ! echo "$LINE" | grep -q "Running"; then
            echo "Error: Not all pods are running."
            echo "Restating k3s service."
            sudo service k3s restart
            all_running=false
            break
        fi
    done

    if [ "$all_running" = true ]; then
        break
    fi

    sleep 60
done

echo "All pods are running."
