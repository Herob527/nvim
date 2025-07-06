FROM nixos/nix:2.26.4 AS nix-builder

# Copy the shell.nix file
WORKDIR /nvim
COPY shell.nix /nvim/shell.nix

# Build the environment
RUN nix-build shell.nix && \
  cp -r ./result/* .

# Set proper working directory and command
WORKDIR /
CMD ["bash"]
