# Use the official GitLab Runner image as base
FROM gitlab/gitlab-runner:latest

# Install required dependencies
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        curl \
        git \
        unzip \
        openssh-client \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Docker Compose (optional)
RUN curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install kubectl (optional, for Kubernetes deployments)
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Set up SSH configuration (optional)
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Switch to root to perform privileged operations
USER root

# Add gitlab-runner user to docker group
RUN usermod -aG docker gitlab-runner

# Switch back to gitlab-runner user
USER gitlab-runner

# Verify installations
RUN docker --version && \
    docker-compose --version && \
    kubectl version --client
