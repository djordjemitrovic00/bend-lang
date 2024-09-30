FROM rust:latest

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y gcc

# Install hvm and bend-lang
RUN cargo install hvm
RUN cargo install bend-lang
RUN mkdir app

COPY [".", "."]

# Run the Bend file when started
CMD ["bend", "run-c", "proba.bend", "-s"]