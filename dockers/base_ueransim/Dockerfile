FROM lte_base

WORKDIR ${LTE_SRC_DIR}

ARG UERANSIM_BUILD_DEPS="cmake make g++ libsctp-dev lksctp-tools build-essential git tar gzip"
ARG UERANSIM_RUN_DEPS="libsctp-dev lksctp-tools iproute2"
ARG UERANSIM_SRC_DIR=UERANSIM
ARG UERANSIM_CLONE_URL=https://github.com/aligungr/UERANSIM
ARG UERANSIM_VERSION="v3.2.2"
ARG UERANSIM_PREFIX=${LTE_BASE_DIR}/ueransim/

ARG CMAKE_FILENAME="cmake-3.21.1.tar.gz"
ARG CMAKE_GET_URL="https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1.tar.gz"
ARG CMAKE_SRC_DIR="cmake-3.21.1"
ARG CMAKE_CMAKE_ARGS="-DCMAKE_USE_OPENSSL=OFF "

RUN apt-get update && apt-get install -y --no-install-recommends ${UERANSIM_BUILD_DEPS} ${UERANSIM_RUN_DEPS} \
	&& cd ${LTE_SRC_DIR} \
	&& wget ${CMAKE_GET_URL} \
	&& tar -xvvpzf ${CMAKE_FILENAME} \
	&& cd ${CMAKE_SRC_DIR} \
	&& mkdir build \
	&& cd build \
	&& cmake ${CMAKE_CMAKE_ARGS} .. \
	&& make ${MAKE_ARGS} \
	&& cd ${LTE_SRC_DIR} \
	&& git clone ${UERANSIM_CLONE_URL} \
	&& cd ${UERANSIM_SRC_DIR} \
	&& git checkout ${UERANSIM_VERSION} \
	&& export PATH=${LTE_SRC_DIR}/${CMAKE_SRC_DIR}/build/bin/:$PATH \
	&& make ${MAKE_ARGS} \
	&& mkdir -p ${UERANSIM_PREFIX} \
	&& mv build ${UERANSIM_PREFIX}/bin \
	&& mv config tools ${UERANSIM_PREFIX}/ \
	&& cd ${LTE_SRC_DIR} \
	&& rm -rf ${CMAKE_FILENAME} ${CMAKE_SRC_DIR} ${UERANSIM_SRC_DIR} \
	&& rm -rf /var/lib/apt/lists/*


