FROM lte_base

WORKDIR ${LTE_SRC_DIR}
COPY packages/fhoss-precompiled.tar.gz ${LTE_SRC_DIR}/
RUN apt-get update && apt-get install -y openjdk-8-jre-headless \
	&& mkdir -p /opt/OpenIMSCore \
	&& cd /opt/OpenIMSCore \
	&& tar -xvvpzf ${LTE_SRC_DIR}/fhoss-precompiled.tar.gz \
	&& apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/*

