FROM lte_base


ARG KAMAILIO_BUILD_DEPS="gcc g++ make git build-essential flex bison libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libbson-dev \
	libyaml-dev libxml2-dev libmysqlclient-dev libmnl-dev libcurl4-openssl-dev libpcre3-dev libradcli-dev libjansson-dev libsctp-dev"
ARG KAMAILIO_RUN_DEPS="ifupdown curl gnupg iptables net-tools iputils-ping netcat libradcli4 libgcrypt20 libssl1.1 libmongoc-1.0-0 libbson-1.0-0 \
        libyaml-0-2 libxml2 libmysqlclient21 libmnl0 libcurl4-openssl-dev libpcre3 libjansson4 libsctp1"
ARG KAMAILIO_SRC_DIR=kamailio
ARG KAMAILIO_CLONE_URL=https://github.com/herlesupreeth/kamailio
ARG KAMAILIO_INCLUDE_MODULES="acc_json cdp cdp_avp db_mysql dialplan ims_auth ims_charging ims_dialog ims_diameter_server ims_icscf ims_ipsec_pcscf ims_isc ims_ocs ims_qos ims_registrar_pcscf ims_registrar_scscf ims_usrloc_pcscf ims_usrloc_scscf outbound presence presence_conference presence_dialoginfo presence_mwi presence_profile presence_reginfo presence_xml pua pua_bla pua_dialoginfo pua_reginfo pua_rpc pua_usrloc pua_xmpp sctp tls utils xcap_client xcap_server xmlops xmlrpc stun sms smsops"
ARG KAMAILIO_EXCLUDE_MODULES="acc_radius app_java app_lua app_lua_sr app_mono app_perl app_python app_python3 app_ruby auth_ephemeral auth_identity auth_radius cnxcc cplc crypto db2_ldap db_berkeley db_cassandra db_mongodb db_oracle db_perlvdb db_postgres db_redis db_sqlite db_unixodbc dnssec erlang evapi geoip geoip2 gzcompress h350 http_async_client http_client jansson janssonrpcc json jsonrpcc kafka kazoo lcr ldap log_systemd lost memcached misc_radius ndb_cassandra ndb_mongodb ndb_redis nsq osp pua_json rabbitmq regex rls rtp_media_server snmpstats systemdops topos_redis uuid websocket xhttp_pi xmpp phonenum peering"
ENV RADCLI=1
ARG KAMAILIO_PREFIX=${LTE_BASE_DIR}/kamailio/

RUN apt-get update && apt-get install -y  --no-install-recommends ${KAMAILIO_BUILD_DEPS} ${KAMAILIO_RUN_DEPS} \
	&& git clone ${KAMAILIO_CLONE_URL} \
	&& cd ${KAMAILIO_SRC_DIR} \
	&& make include_modules="${KAMAILIO_INCLUDE_MODULES}" exclude_modules="${KAMAILIO_EXCLUDE_MODULES}" PREFIX=${KAMAILIO_PREFIX} cfg \
	&& make ${MAKE_ARGS} all PREFIX=${KAMAILIO_PREFIX} \
	&& make install PREFIX=${KAMAILIO_PREFIX} \
	&& ldconfig \
	&& cd ${LTE_SRC_DIR} \
	&& rm -rf ${KAMAILIO_SRC_DIR} \
	&& apt-get purge -y ${KAMAILIO_BUILD_DEPS} && apt-get clean autoclean && apt-get autoremove --yes \
	&& rm -rf /var/lib/apt/lists/* \
	&& adduser --quiet --system --group --disabled-password --shell /bin/false --gecos "Kamailio" --home /var/run/kamailio kamailio \
	&& chown kamailio:kamailio /var/run/kamailio
