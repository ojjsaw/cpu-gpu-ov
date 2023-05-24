# Partial Example from article: https://medium.com/better-programming/docker-wsl-and-oneapi-a-quick-how-to-guide-d7db3363b303
FROM intel/oneapi-basekit:devel-ubuntu20.04 as builder

RUN git clone https://github.com/oneapi-src/oneAPI-samples

RUN cmake /oneAPI-samples/DirectProgramming/DPC++/N-BodyMethods/Nbody
RUN make

FROM intel/oneapi-runtime:latest

COPY - from=builder src/nbody /
CMD ["/nbody"]
