
dockerized LTE / 5G setup: UE + ENB + EPC + IMS + 5G UE / RAN simulator


Components:
 * srsLTE (UE + ENB)
 * open5gs (EPC / 5G core)
 * kamailio SIP (IMS)
 * RTPengine (IMS)
 * UERANSIM (5G UE / RAN simulator)


There are two flavours of srsLTE built:


ZMQ flavour uses ZMQ for UE <> ENB. This one can run in any system
available, for simple testing


RADIO flavour needs a Raspberry PI4B + LimeSDR Mini. This one you can
use to attach commercial UEs to EPC.



Prerequisites:
 * ubuntu 21.04
 * docker
 * docker-compose
 * 8-16G RAM (probably less to actually run, building some ASN sources requires a lot of RAM)
 * 32G disk space

You'll need a fairly recent kernel version, because of SCTP
incompatibilities with docker.

Ubuntu 20.04 works out of the box.

A vagrant file is also provided based on 21.04

How to build:
 * Install ubuntu
 * Install docker
 * Install docker-compose
 * Alternatively, just vagrant up the provided vagrantfile, based on 21.04, it sets up its environment automatically, and you can enable full package compilation at provisioning time

Build and run


```
docker-compose build
```

How to configure:

Several parameters and all IP addresses of network elements are contained in
the .env docker-compose file. Other parameters you'll have to modify the
template config files and/or scripts you'll find under config/ and scripts/
directories.


How to run the ZMQ version (no special hardware needed)

```
sh lte_4g_core.sh
```

Wait for everything to initialize, then run

```
lte_4g_ran_zmq.sh
```

If everything goes right, you'll end up with a shell attached to the
lte_ue_zmq docker instance. Try:

```ping 10.45.0.1``` (the PGW gateway IP)
```ping 8.8.8.8``` (an outside IP, to test if NAT works right)
 
NOTE : The raspberry PI version is build from a separate tree of srsLTE, not
yet merged to mainline. Apparently the changes required for performance
cause the ZMQ versions of UE/ENB to have quite long delays on initial
startup (about 10 minutes). Be patient and they will eventually attach.


How to run 5G Core :

```
sh lte_5g_core.sh
```

Wait for elements to start, then do

```
sh lte_5g_ran_ueransim.sh
```

How to capture traffic :

You can capture pcaps of any network element either by attaching to the
specific docker containeer ("docker-compose exec lte_xxx /bin/bash") and
running tcpdump, or (better) by running tcpdump on the appropriate network
interface docker generates on the host. The provided tcpdump.sh does that for you
and stores pcaps in log/tcpdump/


How to run the RADIO version:

Requirements:
 * LimeSDR Mini USB (available from https://www.crowdsupply.com/lime-micro/limesdr-mini/ - I use the $299 package that includes board, aluminum case and antennas, though you can also use the individual board + antenna + acrylic case available at the same page).
 * Raspberry PI 4B 4GB model (available from https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?resellerType=home, better get a complete kit wich includes case, power supply, cables etc)
 * Any CCID compliant SIM to USB adapter (you will only need this if you need to reprogram the SysmoCOM SIM cards for use with IMS, not needed for normal UE operation)
 * SysmoCOM SIM cards (available from http://shop.sysmocom.de/t/sim-card-related/sim-cards - I use the Green ones but they're obsoleted, get the black oned PLUS ADM keys if you want to reprogram for IMS use)

As an alternative to Raspberry PI, most Intel NUCs or similar systems should work fine


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

subscriber data for your SIM are placed in mongo epc database (edit config/mongo/subscribers.json,
you can also use the lte_hss_epc_web container to create a new subscriber).

Run

```
sh lte_radio.sh
```


How to run IMS:

-- TODO --
