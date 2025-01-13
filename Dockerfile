FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && \
  apt-get install -y --no-install-recommends \
  build-essential \
  byacc \
  ca-certificates \
  flex \
  ffmpeg \
  libpng-dev \
  pkg-config \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/gbdev/rgbds/releases/download/v0.3.8/rgbds-0.3.8.tar.gz && \
  tar -xzf rgbds-0.3.8.tar.gz && \
  cd rgbds-0.3.8 && \
  make -j && \
  make install && \
  cd .. && \
  rm -rf rgbds-0.3.8 rgbds-0.3.8.tar.gz

WORKDIR /app

COPY . .

ENTRYPOINT ["/bin/bash"]
