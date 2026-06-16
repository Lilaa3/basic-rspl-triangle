# Dockerfile
FROM bitnami/minideb:latest


RUN apt-get update && apt-get install -y \
    gdb-multiarch gdbserver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["gdb-multiarch"]