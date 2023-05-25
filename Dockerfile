#https://github.com/oneapi-src/oneVPL/tree/master/tools/legacy/sample_multi_transcode
FROM docker.io/intel/oneapi-aikit:devel-ubuntu20.04

RUN apt-get update && apt-get install -y libva-drm2
ADD cars_320x240.h265 /app/

CMD ["/opt/intel/oneapi/vpl/latest/bin/sample_multi_transcode -hw -i::h265 /app/cars_320x240.h265 -o::mpeg2 /app/out.mpeg2 && sleep 2"]
