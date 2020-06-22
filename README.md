

dockerized LTE setup: UE + ENB + EPC + IMS

 
Components:
 * srsLTE (UE + ENB)
 * open5gs (EPC)
 * kamailio SIP (IMS)
 * RTPengine (IMS)


There are two flavours built:


ZMQ flavour uses ZMQ for UE <> ENB. This one can run in any system
available, for simple testing: 


RADIO flavour needs a Raspberry PI4B + LimeSDR Mini. This one you can
use to attach commercial UEs to EPC.  



Prerequisites:
 * docker
 * docker-compose


You'll need a fairly recent kernel version, because of SCTP
incompatibilities with docker. Ubuntu 20.04 works out of the box.
Centos 7 works *only* if you run a fairly reccent kernel (tested under
5.1.16-1.el7.elrepo.x86_64). Stock 3.10 Centos 7 kernels don't work. 


How to build: 

```
docker-compose build
```

How to configure:

Several parameters and all IP addresses of network elements are contained in
the .env docker-compose file. Other parameters you'll have to modify the
template config files and/or scripts you'll find under config/ and scripts/
directories. 


How to run the ZMQ version: 

```
sh lte_zmq.sh
```

If everything goes right, you'll end up with a shell attached to the
lte_ue_zmq docker instance. Try: 

```ping 10.45.0.1``` (the PGW gateway IP) 
```ping 8.8.8.8``` (an outside IP, to test if NAT works right) 

NOTE : The raspberry PI version is build from a separate tree of srsLTE, not
yet merged to mainline. Apparently the changes required for performance
cause the ZMQ versions of UE/ENB to have quite long delays on initial
startup (about 10 minutes). Be patient and they WILL eventually attach.



You can capture pcaps of any network element either by attaching to the
specific docker containeer ("docker-compose run lte_xxx /bin/bash") and
running tcpdump, or (better) by running tcpdump on the appropriate network
interface docker generates on the host.


How to run the RADIO version: 

-- TODO --

How to run IMS: 

-- TODO --