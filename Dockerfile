FROM ubuntu:20.04 as build
ARG NJOBS=1
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get clean \
    && apt-get update \
    &&  apt-get -y upgrade \
    && apt-get -qq install \
        python3 \
        python3-pip \
        git \
        bison \
        flex \
        gperf \
        libreadline5 \
        libncurses5-dev \
        autoconf \
    && rm -rf /var/cache/apt/archives

RUN git clone https://github.com/steveicarus/iverilog \
    && cd iverilog \
    && sh autoconf.sh \
    && ./configure \
    && make -j${NJOBS} \
    && make install


FROM ubuntu:20.04
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/include/iverilog /usr/local/include/iverilog
COPY --from=build /usr/local/lib/ivl /usr/local/lib/ivl
COPY --from=build /usr/local/lib/ivl/include /usr/local/lib/ivl/include

COPY --from=build /usr/local/share/man /usr/local/share/man



RUN apt-get clean \
    && apt-get update \
    &&  apt-get -y upgrade \
    && apt-get -qq install \
        python3 \
        python3-pip \
    && rm -rf /var/cache/apt/archives

RUN pip install --upgrade pip
RUN pip install \
        cocotb \
        pytest \
        ipython \
        cocotb-test \
        pytest-cov \
        pytest-xdist \
        bitstring \
        pytest-lazy-fixture
