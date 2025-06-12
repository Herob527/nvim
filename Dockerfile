FROM jdxcode/mise:2025.6.1

WORKDIR /nvim
COPY . .

RUN mise settings experimental=true

RUN bash -c $(mise generate bootstrap)

CMD ["nvim"]
