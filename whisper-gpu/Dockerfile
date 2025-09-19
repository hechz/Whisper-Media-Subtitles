FROM ubuntu:24.04
FROM nvidia/cuda:12.9.0-runtime-ubuntu24.04

# Install ffmpeg and build tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    apt-utils \
    dialog \
    ffmpeg \
    git \
	python3 \
	python3-pip \
	wget \
    vim \
    less \
    jq \
    cifs-utils \
    smbclient \
    iproute2 \
    bind9-host \
    && rm -rf /var/lib/apt/lists/*
RUN apt purge -y \
    systemd* \
    dbus*
RUN apt autoremove -y

# Set working directory
WORKDIR /app

#Install nVidia Utils
RUN apt-get update && apt-get install -y nvidia-utils-525

# Set python3 as default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install PyTorch with CUDA support (for GPU)
RUN pip3 install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
RUN pip3 install --break-system-packages git+https://github.com/openai/whisper.git

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Optional: Download English model in advance
RUN whisper --model large-v3 --language English --output_format txt --help || true

# Set default command
ENTRYPOINT ["/entrypoint.sh"]