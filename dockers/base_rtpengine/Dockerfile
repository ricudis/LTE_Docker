FROM lte_base

ARG RTPENGINE_BUILD_DEPS="gcc g++ cmake git meson ninja-build build-essential flex bison debhelper-compat default-libmysqlclient-dev \
	gperf libavcodec-dev libavfilter-dev libavformat-dev \
	libavutil-dev libbencode-perl libcrypt-openssl-rsa-perl libcrypt-rijndael-perl libcurl4-openssl-dev libdigest-crc-perl \
	libdigest-hmac-perl libevent-dev libglib2.0-dev libhiredis-dev libio-multiplex-perl libio-socket-inet6-perl libiptc-dev \
	libjson-glib-dev libnet-interface-perl libpcap0.8-dev libpcre3-dev libsocket6-perl libspandsp-dev libssl-dev libswresample-dev \
	libsystemd-dev libxmlrpc-core-c3-dev markdown zlib1g-dev libip4tc-dev libip6tc-dev libxtables-dev"
ARG RTPENGINE_PROJECT_DIR=rtpengine
ARG RTPENGINE_CLONE_URL=https://github.com/sipwise/rtpengine.git
ARG RTPENGINE_PACKAGES="ngcp-rtpengine-daemon ngcp-rtpengine-iptables ngcp-rtpengine-kernel-dkms ngcp-rtpengine-recording-daemon ngcp-rtpengine-utils ngcp-rtpengine"

RUN apt-get update && apt-get install -y --no-install-recommends ${RTPENGINE_BUILD_DEPS} \
        && git clone ${RTPENGINE_CLONE_URL} \
        && cd ${RTPENGINE_PROJECT_DIR} \
        && export DEB_BUILD_PROFILES="pkg.ngcp-rtpengine.nobcg729" \
        && dpkg-buildpackage -uc -us -d \
        && cd .. \
        && rm -rf ${RTPENGINE_PROJECT_DIR} \
        && apt-get purge -y ${RTPENGINE_BUILD_DEPS} && apt-get clean autoclean && apt-get autoremove --yes \
        && apt install -y ./*.deb \
        && unset DEB_BUILD_PROFILES \
        && ldconfig
