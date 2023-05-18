FROM docker.io/ubuntu:20.04

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Update the package lists and install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    intel-opencl-icd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the default Python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

# Create a directory for your application
WORKDIR /app

# Install Python dependencies
RUN python3 -m pip install --no-cache-dir --upgrade pip

RUN python3 -m pip install --no-cache-dir opencv-python-headless
    
RUN python3 -m pip install --no-cache-dir openvino-dev[caffe]
    
ENV DEVICE=GPU

ENTRYPOINT ["/bin/bash", "-c", "omz_downloader --name mobilenet-ssd && omz_converter --name mobilenet-ssd --precisions FP16 && benchmark_app -m public/mobilenet-ssd/FP16/mobilenet-ssd.xml -hint throughput -t 20 -d ${DEVICE} && sleep 2"]
