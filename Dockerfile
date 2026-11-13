# docker run -it -v $(pwd):/workspace --user $(id -u):$(id -g)

FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install common development tools and utilities
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    vim \
    wget \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo privileges
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up workspace directory
WORKDIR /workspace

# Change ownership of workspace to the dev user
RUN chown -R $USERNAME:$USERNAME /workspace

# Switch to non-root user
USER $USERNAME

# Set default shell to bash
ENV SHELL=/bin/bash

CMD ["/bin/bash"]
