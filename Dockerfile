FROM python:3.12.2-bookworm
ARG SDF_VERSION=0.2.1

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install sdf
RUN if [ "$(uname -m)" = "aarch64" ]; then \
    curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${SDF_VERSION} --target aarch64-unknown-linux-gnu ; \
    else \
    curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${SDF_VERSION} ; \
    fi
# replace above with a pre-built image?

COPY entrypoint.sh /entrypoint.sh

# Set the code file as the entry point
ENTRYPOINT ["/entrypoint.sh"]