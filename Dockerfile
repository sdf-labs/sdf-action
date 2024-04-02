FROM python:3.12.2-bookworm
ARG SDF_VERSION=0.1.184

# Install dependencies
RUN apt-get update && apt-get install -y \
    yq \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install sdf
RUN curl -LSfs https://cdn.sdf.com/releases/download/install.sh | bash -s -- --version ${SDF_VERSION}

# Install dbt-snowflake plugin using pip
RUN python3.12 -m venv .venv && . .venv/bin/activate \
    && python3 -m pip install dbt-snowflake==1.7.2 \
    && python3 -m pip install --upgrade dbt-core==1.7.9 \
    && python3 -m pip install protobuf==4.25.3

# Copy your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Set the code file as the entry point
ENTRYPOINT ["/entrypoint.sh"]