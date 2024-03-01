# Debian bookworm uses 2.26 glibc where 2.35 is required to run sdf
FROM rust:1.76.0-bookworm
ARG SDF_VERSION=0.1.169

# Install dependencies
RUN apt-get update && apt-get install yq -y

# Install sdf
RUN curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${SDF_VERSION}

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
