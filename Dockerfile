FROM postgres:17

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-server-dev-all \
    && rm -rf /var/lib/apt/lists/*

# Install pgvector
RUN git clone --branch v0.5.1 https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make \
    && make install

# Create initialization script to enable pgvector extension
RUN echo 'CREATE EXTENSION IF NOT EXISTS vector;' > /docker-entrypoint-initdb.d/01-init-vector.sql