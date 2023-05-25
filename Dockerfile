#https://github.com/oneapi-src/oneVPL/tree/master/tools/legacy/sample_multi_transcode
FROM docker.io/intel/oneapi-aikit:devel-ubuntu20.04

RUN apt-get update && apt-get install -y libva-drm2

ENTRYPOINT ["/bin/bash","-c","/opt/intel/oneapi/vpl/latest/bin/sample_multi_transcode -hw -i::h265 /opt/intel/oneapi/vpl/latest/examples/content/cars_320x240.h265 -o::mpeg2 /opt/intel/oneapi/vpl/latest/examples/content/out.mpeg2 && sleep 2"]
