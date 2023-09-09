# ================================
# Build image (Ubuntu 22.04)
# ================================
FROM swift:5.8-jammy as build

# Update system packages
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Set up a build area
WORKDIR /build

# Resolve dependencies, creating a cached layer
COPY ./Package.* ./
RUN swift package resolve

# Copy entire project into container
COPY . .

# Build everything, with optimizations
RUN swift build -c release --static-swift-stdlib

# Set up a staging area
WORKDIR /staging

# Copy the executable
RUN mv `swift build --package-path /build -c release --show-bin-path`/app ./

# Copy Public directory, if it exists. Ensure it's contents aren't writable.
RUN [ -d /build/Public ] && { mv /build/Public /staging/Public && chmod -R a-w /staging/Public; } || true

# ================================
# Run image
# ================================
FROM ubuntu:jammy

# Update system packages and install necessary packages
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y ca-certificates tzdata libsqlite3-dev \
    && rm -r /var/lib/apt/lists/*

# Switch to a new home directory
WORKDIR /app

# Copy over needed files
COPY --from=build /staging /app

# Start the Alchemy app on port 3000
EXPOSE 3000
ENTRYPOINT [ "./app" ]
CMD ["serve", "--host", "0.0.0.0", "--port", "3000"]