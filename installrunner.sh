#!/bin/bash

# Build the custom GitLab Runner image
docker build -t gitlab-runner-custom .

# Run the GitLab Runner container
docker run -d \
    --name gitlab-runner \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /srv/gitlab-runner/config:/etc/gitlab-runner \
    gitlab-runner-custom

# Register the runner with GitLab
echo -e "\n\033[1;33m=== Registering Runner ===\033[0m"
echo "You'll need your GitLab instance URL and registration token from:"
echo "GitLab Project -> Settings -> CI/CD -> Runners"
docker exec -it gitlab-runner gitlab-runner register
