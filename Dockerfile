# Use an official CUDA base image with Python 3.10
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu20.04

# Set the Python version and ensure correct locale settings
ARG PYTHON_VERSION=3.10
ENV CUDA_HOME=/usr/local/cuda

# Install basic utilities and necessary dependencies
RUN apt update -y && \
    apt install -y software-properties-common python3-launchpadlib && \
    apt update -y && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt update -y && \
    apt install -y gcc g++ aria2 git git-lfs wget libgl1 libglib2.0-0 ffmpeg cmake libgtk2.0-0 libopenmpi-dev

# Install Python and pip
RUN apt install -y python3-pip && pip3 install --upgrade pip

# Install PyTorch with CUDA support and other Python packages
RUN pip3 install torch==2.2.1+cu121 torchvision==0.17.1+cu121 torchaudio==2.2.1+cu121 torchtext==0.17.1 torchdata==0.7.1 --extra-index-url https://download.pytorch.org/whl/cu121 -U

# Install other Python dependencies
RUN pip3 install notebook pyngrok pickleshare ipywidgets opencv-python imageio imageio-ffmpeg diffusers transformers accelerate xformers==0.0.25 gradio pydantic==1.10.15 omegaconf peft Pillow==9.5.0

# Set the working directory inside the container
WORKDIR /workspace/StoryDiffusion

# Copy all local files into the container's working directory
COPY *.py .

# Command to run the prediction script
CMD ["python3", "/workspace/StoryDiffusion/predict.py"]
