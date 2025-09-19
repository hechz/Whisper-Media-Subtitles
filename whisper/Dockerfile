# Use a lightweight Ubuntu image with Python 3
FROM ubuntu:24.10

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Make sure 'python' points to 'python3'
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Upgrade pip and install CPU-only PyTorch + Whisper
pip3 install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
pip3 install --break-system-packages git+https://github.com/openai/whisper.git

# Optional: Set environment variables for threading performance
ENV OMP_NUM_THREADS=8
ENV MKL_NUM_THREADS=8

# Set working directory
WORKDIR /app

# Default command
ENTRYPOINT ["whisper"]
