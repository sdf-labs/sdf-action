FROM python:3.12.2-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

# Set the code file as the entry point
ENTRYPOINT ["/entrypoint.sh"]