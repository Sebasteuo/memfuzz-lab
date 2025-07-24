FROM ubuntu:22.04

# ---------- Base toolchain + libs ----------
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        afl++ build-essential python3 python3-pip python3-dev git wget unzip \
        libcapstone-dev libdistorm3-dev \
        yara libyara-dev libjansson-dev && \
    rm -rf /var/lib/apt/lists/*

# ---------- Volatility 3 ----------
RUN git clone --depth 1 https://github.com/volatilityfoundation/volatility3 /opt/volatility3 && \
    pip3 install --no-cache-dir -r /opt/volatility3/requirements.txt && \
    ln -s /opt/volatility3/vol.py /usr/local/bin/vol

# ---------- Non-root fuzzing user ----------
RUN useradd -m fuzz
USER fuzz
WORKDIR /home/fuzz

CMD ["/bin/bash"]

