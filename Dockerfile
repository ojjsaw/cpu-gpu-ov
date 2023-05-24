FROM intel/oneapi-basekit:devel-ubuntu20.04 as builder

RUN git clone https://github.com/oneapi-src/oneAPI-samples

RUN cmake /oneAPI-samples/DirectProgramming/C++SYCL/N-BodyMethods/Nbody
RUN make

FROM intel/oneapi-runtime:latest

COPY - from=builder src/nbody /
CMD ["/nbody"]
