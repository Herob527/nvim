FROM jdxcode/mise:2025.6.1 AS base

WORKDIR /nvim/.config/nvim

COPY ./mise.toml ./mise.toml

ENV MISE_CACHE_DIR=/root/.cache
ENV XDG_CONFIG_HOME=/nvim/.config

RUN mise settings experimental=true

RUN mise activate | bash

RUN mise trust

RUN --mount=type=cache,target=/root/.cache mise install -y

FROM base AS final

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
