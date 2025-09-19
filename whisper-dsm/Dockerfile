# Use a lightweight Ubuntu image with Python 3
FROM ubuntu:24.10

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    apt-utils \
    python3 \
    python3-pip \
    git \
    ffmpeg \
    vim \
    less \
    vim \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Make sure 'python' points to 'python3'
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Upgrade pip and install CPU-only PyTorch + Whisper
RUN pip3 install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    pip3 install --break-system-packages git+https://github.com/openai/whisper.git

# Optional: Set environment variables for threading performance
ENV OMP_NUM_THREADS=4
ENV MKL_NUM_THREADS=4
ENV MODEL=base
ENV OUTPUT_FORMAT=srt
ENV SOURCE_LANG=en
ENV TASK=transcribe
ENV FILE='[enter_file_name]'

# Set working directory
WORKDIR /app

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Default command
ENTRYPOINT ["/entrypoint.sh"]
