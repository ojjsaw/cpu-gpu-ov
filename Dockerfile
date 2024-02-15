FROM docker.io/openvino/ubuntu20_dev:2023.2.0

ENV DEVICE=GPU

ENTRYPOINT ["/bin/bash", "-c", "omz_downloader --name mobilenet-ssd && omz_converter --name mobilenet-ssd --precisions FP16 && benchmark_app -m public/mobilenet-ssd/FP16/mobilenet-ssd.xml -hint throughput -t 20 -d ${DEVICE} && sleep 2"]
