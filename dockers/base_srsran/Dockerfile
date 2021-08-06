FROM lte_base

WORKDIR ${LTE_SRC_DIR}

ARG SOAPYSDR_PROJECT=SoapySDR
ARG SOAPYSDR_BUILD_DEPS="gcc g++ cmake git"
ARG SOAPYSDR_SRC_DIR=${SOAPYSDR_PROJECT}
ARG SOAPYSDR_CLONE_URL=https://github.com/pothosware/SoapySDR.git

ARG LIMESDR_BUILD_DEPS="gcc g++ cmake git libi2c-dev libusb-1.0-0-dev libsqlite3-dev"
ARG LIMESDR_RUN_DEPS="libi2c0 libusb-1.0-0 libsqlite3-0"
ARG LIMESDR_SRC_DIR=LimeSuite
ARG LIMESDR_CLONE_URL=https://github.com/myriadrf/LimeSuite.git
ARG LIMESDR_CMAKE_ARGS="-DENABLE_REMOTE=1"

ARG SRSRAN_BUILD_DEPS="gcc g++ cmake git libfftw3-dev libmbedtls-dev libboost-program-options1.71-dev libconfig++-dev libczmq-dev libzmq3-dev libsctp-dev"
ARG SRSRAN_RUN_DEPS="libfftw3-bin libfftw3-3 libfftw3-double3 libfftw3-long3 libfftw3-single3 libmbedcrypto3 libmbedtls12 libmbedx509-0 libboost-program-options1.71.0 libconfig++ libczmq4 libzmq5 libsctp1 libpcsclite-dev"
ARG SRSRAN_SRC_DIR=srsRAN
ARG SRSRAN_CLONE_URL=https://github.com/srsran/srsRAN.git
ARG SRSRAN_VERSION="release_21_04"
ARG SRSRAN_PREFIX=${LTE_BASE_DIR}/srsran/
ARG SRSRAN_CMAKE_ARGS="-DCMAKE_INSTALL_PREFIX=${SRSRAN_PREFIX}"

RUN apt-get update && apt-get install -y --no-install-recommends ${SOAPYSDR_BUILD_DEPS} ${LIMESDR_BUILD_DEPS} ${LIMESDR_RUN_DEPS} ${SRSRAN_BUILD_DEPS} ${SRSRAN_RUN_DEPS} \
	&& cd ${LTE_SRC_DIR} \
	&& git clone ${SOAPYSDR_CLONE_URL} \
	&& cd ${SOAPYSDR_SRC_DIR} \
	&& mkdir build \
	&& cd build \
	&& cmake ../ \
	&& make ${MAKE_ARGS} \
	&& make install \
	&& ldconfig \
	&& cd ${LTE_SRC_DIR} \
	&& git clone ${LIMESDR_CLONE_URL} \
	&& cd ${LIMESDR_SRC_DIR} \
	&& git checkout stable \
	&& mkdir build_dir \
	&& cd build_dir \
	&& cmake ${LIMESDR_CMAKE_ARGS} .. \
	&& make ${MAKE_ARGS} \
	&& make install \
	&& ldconfig \
	&& cd ${LTE_SRC_DIR} \
	&& git clone ${SRSRAN_CLONE_URL} \
	&& cd ${SRSRAN_SRC_DIR} \
	&& git checkout ${SRSRAN_VERSION} \
	&& mkdir build_dir \
	&& cd build_dir \
	&& cmake ${SRSRAN_CMAKE_ARGS} .. \
	&& make ${MAKE_ARGS} \
	&& make install \
	&& ldconfig \
	&& cd ${LTE_SRC_DIR} \
	&& rm -rf ${SOAPYSDR_SRC_DIR} ${LIMESDR_SRC_DIR} ${SRSRAN_SRC_DIR} \
	&& apt-get purge -y ${SOAPYSDR_BUILD_DEPS} ${LIMESDR_BUILD_DEPS} ${SRSRAN_BUILD_DEPS} && apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*
