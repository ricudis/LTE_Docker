FROM lte_base

ARG OPEN5GS_BUILD_DEPS="gcc g++ cmake git meson ninja-build build-essential flex bison \
	libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev \
	libbson-dev libyaml-dev libmicrohttpd-dev libsctp-dev"
ARG OPEN5GS_RUN_DEPS="libgcrypt20 libssl1.1 libmongoc-1.0-0 libbson-1.0-0 \
	libyaml-0-2 libmicrohttpd12 libidn11 libsctp1 radvd libcurl4-gnutls-dev"
ARG OPEN5GS_SRC_DIR=open5gs
ARG OPEN5GS_CLONE_URL=https://github.com/open5gs/open5gs
ARG OPEN5GS_PREFIX=${LTE_BASE_DIR}/open5gs/

ARG MAKE_ARGS="-j2"

RUN apt-get update && apt-get install -y --no-install-recommends ${OPEN5GS_BUILD_DEPS} ${OPEN5GS_RUN_DEPS} \
	&& git clone ${OPEN5GS_CLONE_URL} \
	&& cd ${OPEN5GS_SRC_DIR} \
	&& meson build_dir -Dprefix=${OPEN5GS_PREFIX} \
	&& ninja -C build_dir \
	&& cd build_dir \
	&& ninja install \
	&& ldconfig \
	&& cd .. \
	&& mv webui ${OPEN5GS_PREFIX} \
	&& cd ${LTE_SRC_DIR} \
	&& rm -rf ${OPEN5GS_SRC_DIR} \
	&& apt-get purge -y ${OPEN5GS_BUILD_DEPS} && apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*
	
