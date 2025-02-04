#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Define variables
GITLAB_RUNNER_URL="https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
GITLAB_RUNNER_BIN="/usr/local/bin/gitlab-runner"
GITLAB_RUNNER_USER="gitlab-runner"
GITLAB_RUNNER_HOME="/home/$GITLAB_RUNNER_USER"

# Download the GitLab Runner binary
sudo curl -L --output "$GITLAB_RUNNER_BIN" "$GITLAB_RUNNER_URL"

# Give it permission to execute
sudo chmod +x "$GITLAB_RUNNER_BIN"

# Create a GitLab Runner user if it does not exist
if ! id "$GITLAB_RUNNER_USER" &>/dev/null; then
    sudo useradd --comment 'GitLab Runner' --create-home "$GITLAB_RUNNER_USER" --shell /bin/bash
    echo "User $GITLAB_RUNNER_USER created."
else
    echo "User $GITLAB_RUNNER_USER already exists. Skipping creation."
fi

# Install GitLab Runner as a service
sudo gitlab-runner install --user="$GITLAB_RUNNER_USER" --working-directory="$GITLAB_RUNNER_HOME"

# Start the GitLab Runner service
sudo gitlab-runner start

echo "GitLab Runner installation and setup complete."
