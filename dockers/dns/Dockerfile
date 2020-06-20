
FROM lte_base

ARG ADD_PACKAGES="dnsmasq"
RUN apt-get update && apt-get install -y --no-install-recommends ${ADD_PACKAGES} \
        && apt-get clean autoclean && apt-get autoremove --yes \
        && rm -rf /var/lib/apt/lists/*
        
CMD ${LTE_BASE_DIR}/scripts/dns/dns.sh
