FROM ubuntu:21.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ARG LTE_BASE_DIR=/opt/LTE/
ENV LTE_BASE_DIR=/opt/LTE/
ARG LTE_SRC_DIR=${LTE_BASE_DIR}/src/
ENV LTE_SRC_DIR=${LTE_BASE_DIR}/src/
ARG MAKE_ARGS="-j2"

WORKDIR ${LTE_SRC_DIR}

ARG ADD_PACKAGES="apt-transport-https ca-certificates curl gnupg lsb-release \
	ca-certificates tzdata usbutils screen net-tools vim ifupdown iptables net-tools \
	iputils-ping wget tcpdump ntpdate ntp netcat apt-utils tmux iproute2"

RUN apt-get update && apt-get install -y --no-install-recommends ${ADD_PACKAGES} \
	&& apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*
