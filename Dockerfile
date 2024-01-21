# Base image
FROM nvidia/cuda:12.2.0-devel-ubuntu20.04

# Environment variables
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /home

# Update packages & installation
RUN set -x && \
    apt update && \
    apt upgrade -y && \
    apt install -y python3 python3-pip && \
    apt install -y python3-tk && \
    apt install -y x11-apps sqlite3 libsqlite3-dev zlib1g-dev libjpeg-dev ntpdate wget sudo nano redis-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add NVIDIA cuDNN repository and install cuDNN
RUN apt-get update && apt-get install -y --no-install-recommends gnupg2 curl && \
    curl -fsSL https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    libcudnn8 \
    libcudnn8-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/apt/sources.list.d/nvidia-ml.list

# Install NCCL
RUN apt-get update && apt-get install -y --no-install-recommends \
    libnccl2 \
    libnccl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set matplotlib backend
ENV MPLBACKEND="TkAgg"

# Python requirements
COPY requirements.txt .
# Upgrade pip
RUN pip install --upgrade pip
# Install requirements
RUN pip install cupy-cuda12x
RUN pip install numpy==1.23.0
RUN pip install opencv-python
RUN pip install --no-cache-dir -r requirements.txt
# Copy current directory contents
COPY . .
