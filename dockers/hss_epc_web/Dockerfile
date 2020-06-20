FROM lte_base_open5gs

ARG OPEN5GS_WEB_RUN_DEPS="nodejs npm"
ARG OPEN5GS_PREFIX=${LTE_BASE_DIR}/open5gs/

RUN apt-get update && apt-get install -y --no-install-recommends ${OPEN5GS_WEB_RUN_DEPS} \
	&& cd ${OPEN5GS_PREFIX}/webui/ \
	&& npm install \
	&& rm -rf /var/lib/apt/lists/*

CMD ${LTE_BASE_DIR}/scripts/hss_epc_web/hss_epc_web.sh
