#!/bin/bash

# Step 1: Build the Docker image
docker build -t storydiffusion:latest .

# Step 2: Run the Docker container with GPU support
docker run --gpus all \
    --name storydiffusion_container \
    -v $(pwd):/workspace/StoryDiffusion \
    -it storydiffusion:latest
