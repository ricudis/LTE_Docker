

dockerized LTE setup: UE + ENB + EPC + IMS

 
Components:
 * srsLTE (UE + ENB)
 * open5gs (EPC)
 * kamailio SIP (IMS)
 * RTPengine (IMS)


There are two flavours built:


ZMQ flavour uses ZMQ for UE <> ENB. This one can run in any system
available, for simple testing


RADIO flavour needs a Raspberry PI4B + LimeSDR Mini. This one you can
use to attach commercial UEs to EPC.  



Prerequisites:
 * ubuntu 20.04
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
startup (about 10 minutes). Be patient and they will eventually attach.

You can capture pcaps of any network element either by attaching to the
specific docker containeer ("docker-compose exec lte_xxx /bin/bash") and
running tcpdump, or (better) by running tcpdump on the appropriate network
interface docker generates on the host.


How to run the RADIO version: 


Compile latest LimeUtil (you can also use the lte_base_srslte or any image
derived from it, like lte_ue_* / lte_enb_* running in priviledge mode so it
can access USB).

Connect LimeSDR Mini to Raspberry PI, *on a USB3 port* (the blue ones).

Run

```LimeUtil  --update```

to upgrade the LimeSDR firmware to latest version 

Edit .env and set : 

1) MCC/MNC for your SIM card (oh yes you need a programmable SIM card too, I use sysmocom) 
2) EARFCN_DL value that works with your mobile and won't send the police right up to your door
(location and UE specific. Google for EARFCN values. better to make some experiments and lower 
TX gain on srsenb to the lowest value that works in your environment so you don't cause 
interference too far away from the testbed)

subscriber data for your SIM are placed in mongo epc database (edit
config/mongo/subscribers.json, you can also use the lte_epc_web container to
create a new subscriber). 

sh lte_radio.sh

How to run IMS: 

-- TODO --