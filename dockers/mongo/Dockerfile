FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ARG LTE_BASE_DIR=/opt/LTE/
ENV LTE_BASE_DIR=/opt/LTE/
ARG LTE_SRC_DIR=${LTE_BASE_DIR}/src/
ENV LTE_SRC_DIR=${LTE_BASE_DIR}/src/

WORKDIR ${LTE_SRC_DIR}

ARG ADD_PACKAGES="mongo-tools mongodb-server mongodb-clients netcat"
RUN apt-get update && apt-get install -y --no-install-recommends ${ADD_PACKAGES} \
        && apt-get clean autoclean && apt-get autoremove --yes \
        && rm -rf /var/lib/apt/lists/*

CMD ${LTE_BASE_DIR}/scripts/mongo/mongo.sh
