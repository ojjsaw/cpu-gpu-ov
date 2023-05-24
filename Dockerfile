# https://github.com/oneapi-src/oneAPI-samples/blob/master/DirectProgramming/C%2B%2BSYCL/N-BodyMethods/Nbody/README.md
FROM docker.io/intel/oneapi-basekit:devel-ubuntu20.04 as builder

RUN git clone https://github.com/oneapi-src/oneAPI-samples

RUN cmake /oneAPI-samples/DirectProgramming/C++SYCL/N-BodyMethods/Nbody
RUN make

FROM docker.io/intel/oneapi-runtime:latest

COPY --from=builder src/nbody /
CMD ["/nbody"]
