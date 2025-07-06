FROM jdxcode/mise:2025.6.1 AS base
WORKDIR /nvim/.config/nvim

# Set environment variables early
ENV MISE_EXPERIMENTAL=true
ENV XDG_CONFIG_HOME=/nvim/.config
ENV XDG_DATA_HOME=/nvim/.local/share

# Copy only mise.toml first for better caching
COPY ./mise.toml ./mise.toml

# Use BuildKit cache mount for mise's actual cache directory
RUN --mount=type=cache,target=/mise \
  --mount=type=cache,target=/root/.cache/mise \
  mise trust && mise install

FROM base AS final
# Copy the rest of your files
COPY . ./
ENTRYPOINT ["/bin/bash"]
