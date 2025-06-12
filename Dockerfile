FROM jdxcode/mise:2025.6.1

WORKDIR /nvim
COPY . .

RUN mise settings experimental=true

RUN cp /nvim/init.lua /nvim//lua/init.lua

ENTRYPOINT [ "/bin/bash", "-c" ]

CMD ["nvim", "--headless"]
