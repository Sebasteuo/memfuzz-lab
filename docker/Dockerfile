FROM ubuntu:22.04

# ---------- Base toolchain + libs ----------
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        afl++ build-essential python3 python3-pip python3-dev git wget unzip \
        libcapstone-dev libdistorm3-dev \
        yara libyara-dev libjansson-dev python3-yara \
        qemu-user-static binutils-multiarch && \
    rm -rf /var/lib/apt/lists/*

# ---------- Volatility 3 ----------
RUN pip3 install --no-cache-dir volatility3 && \
    ln -s /usr/local/bin/vol /usr/local/bin/vol.py

# ---------- Non-root fuzzing user ----------
RUN useradd -m fuzz
USER fuzz
WORKDIR /home/fuzz

CMD ["/bin/bash"]

