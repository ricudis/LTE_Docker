
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ARG LTE_BASE_DIR=/opt/LTE/
ENV LTE_BASE_DIR=/opt/LTE/
ARG LTE_SRC_DIR=${LTE_BASE_DIR}/src/
ENV LTE_SRC_DIR=${LTE_BASE_DIR}/src/

ARG MAKE_ARGS="-j"

WORKDIR ${LTE_SRC_DIR}

# todo fixes
# https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device
#

ARG ADD_PACKAGES="ca-certificates tzdata usbutils screen net-tools vim ifupdown iptables net-tools \
	iputils-ping wget tcpdump ntpdate ntp netcat apt-utils tmux"

RUN apt-get update && apt-get install -y --no-install-recommends ${ADD_PACKAGES} \
	&& apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*
