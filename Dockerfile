FROM nixos/nix:2.26.4 AS nix-builder

# Set up environment
ENV NIX_PATH=nixpkgs=channel:nixos-unstable
ENV XDG_CACHE_HOME=/tmp/.cache
ENV XDG_CONFIG_HOME=/tmp/.config
ENV XDG_DATA_HOME=/tmp/.local/share

# Install nix packages
COPY flake.nix ./
RUN nix-shell --command "true"  # Initialize nix-shell
RUN nix-shell --command "nix profile install nixpkgs#nix"  # Install nix
RUN nix build --file default.nix  # Build environment

# Multi-stage build to reduce image size
FROM debian:12-slim

# Copy only the necessary files
COPY --from=nix-builder /nix/store/. /nix/store/
COPY --from=nix-builder /tmp/.config/nixpkgs /tmp/.config/nixpkgs
COPY --from=nix-builder /root/.nix-profile /root/.nix-profile

# Set up environment
ENV PATH=/root/.nix-profile/bin:/nix/store/.link:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NIX_PATH=nixpkgs=channel:nixos-unstable
ENV XDG_CACHE_HOME=/tmp/.cache
ENV XDG_CONFIG_HOME=/tmp/.config
ENV XDG_DATA_HOME=/tmp/.local/share

# Set working directory
WORKDIR /projects

# Copy project files
COPY . .

# Make scripts executable
RUN chmod +x ./*.sh

# Set entrypoint
ENTRYPOINT ["/root/.nix-profile/bin/bash"]
