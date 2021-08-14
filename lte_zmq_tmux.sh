#!/bin/sh

session="lte"
# set up tmux
tmux start-server
window_no=0
tmux new-session -d -s ${session} "bash -i"

for cnt in lte_dns lte_mongo lte_mysql lte_hss_epc lte_hss_epc_web lte_pcrf lte_sgwc lte_sgwu lte_pgw lte_mme lte_enb_zmq lte_ue_zmq ; do
	window_no=`expr $window_no + 1`
	mkdir -p log/$cnt 2> /dev/null 
	echo -n "Starting $cnt in window $window_no..."
	tmux new-window -t ${session}:${window_no} -n $cnt "docker-compose up $cnt"
	sleep 5
	echo ""
done

window_no=`expr $window_no + 1`

echo -n "Starting bash in lte_ue_zmq context in window $window_no..."
tmux new-window -t ${session}:${window_no} -n lte_ue_shell "docker-compose exec lte_ue_zmq /bin/bash"

echo "Attaching to tmux..."
tmux attach-session -t $session
