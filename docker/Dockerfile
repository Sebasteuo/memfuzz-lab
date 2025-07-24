FROM ubuntu:22.04

# ----- Install AFL++ and basic build tools -----
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        afl++ build-essential python3 python3-pip git wget unzip \
        libcapstone-dev libdistorm3-dev && \
    rm -rf /var/lib/apt/lists/*

# ----- Install Volatility 3 -----
RUN git clone --depth 1 https://github.com/volatilityfoundation/volatility3 /opt/volatility3 && \
    pip3 install -r /opt/volatility3/requirements.txt && \
    ln -s /opt/volatility3/vol.py /usr/local/bin/vol

# ----- Non-root user for fuzzing -----
RUN useradd -m fuzz
USER fuzz
WORKDIR /home/fuzz

CMD ["/bin/bash"]
