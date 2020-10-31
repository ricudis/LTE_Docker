FROM lte_base

ARG UERANSIM_BUILD_DEPS="make golang g++ openjdk-11-jdk-headless maven libsctp-dev lksctp-tools build-essential git"
ARG UERANSIM_RUN_DEPS="openjdk-11-jre-headless libsctp-dev lksctp-tools"
ARG UERANSIM_SRC_DIR=UERANSIM
ARG UERANSIM_CLONE_URL=https://github.com/aligungr/UERANSIM

ARG GNBSIM_SRC_DIR="gnbsim"
ARG GNBSIM_CLONE_DIR="https://github.com/hhorai/gnbsim"

ARG MAKE_ARGS="-j2"

RUN apt-get update && apt-get install -y --no-install-recommends ${UERANSIM_BUILD_DEPS} ${UERANSIM_RUN_DEPS} \
	&& git clone ${GNBSIM_CLONE_DIR} \
	&& cd ${GNBSIM_SRC_DIR} \
	&& make \
	&& make test \
	&& cd ${LTE_BASE_DIR}/src \
	&& git clone ${UERANSIM_CLONE_URL} \
	&& cd ${UERANSIM_SRC_DIR} \
	&& export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/ \
	&& sh build.sh \
	&& apt-get purge -y ${UERANSIM_BUILD_DEPS} && apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*
