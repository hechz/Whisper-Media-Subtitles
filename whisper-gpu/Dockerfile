FROM nvidia/cuda:13.0.1-runtime-ubuntu24.04

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

# Set python3 as default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1


# Install PyTorch with CUDA support (for GPU)
RUN pip3 install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
RUN pip3 install --break-system-packages git+https://github.com/openai/whisper.git


# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set default command
ENTRYPOINT ["/entrypoint.sh"]