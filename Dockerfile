FROM docker.io/ubuntu:20.04

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Update the package lists and install necessary dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    intel-opencl-icd \
    ffmpeg \
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

RUN mkdir neo \
    && cd neo \
    && wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.13700.14/intel-igc-core_1.0.13700.14_amd64.deb \
    && wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.13700.14/intel-igc-opencl_1.0.13700.14_amd64.deb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/intel-level-zero-gpu-dbgsym_1.3.26032.30_amd64.ddeb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/intel-level-zero-gpu_1.3.26032.30_amd64.deb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/intel-opencl-icd-dbgsym_23.13.26032.30_amd64.ddeb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/intel-opencl-icd_23.13.26032.30_amd64.deb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/libigdgmm12_22.3.0_amd64.deb \
    && wget https://github.com/intel/compute-runtime/releases/download/23.13.26032.30/ww13.sum \
    && sha256sum -c ww13.sum \
    && dpkg -i *.deb
    
ENV DEVICE=GPU

ENTRYPOINT ["/bin/bash", "-c", "omz_downloader --name mobilenet-ssd && omz_converter --name mobilenet-ssd --precisions FP16 && benchmark_app -m public/mobilenet-ssd/FP16/mobilenet-ssd.xml -hint throughput -t 20 -d ${DEVICE} && sleep 2"]
