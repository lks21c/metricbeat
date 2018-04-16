#!/usr/bin/env bash

bin=`dirname "$this"`
bin=`cd "$bin"; pwd`
export SERVERLIST="${bin}/serverlist/serverlist_$1"

for server in `cat "$SERVERLIST"`; do
  echo $server;
  rsync -av metricbeat-6.1.4-linux-x86_64 root@$server:~/;
  ssh $server "ln -s /root/metricbeat-6.1.4-linux-x86_64 /root/metricbeat"
  scp -r config/metricbeat.yml root@$server:~/metricbeat;
  scp -r sbin root@$server:~/metricbeat;
  ssh $server "chmod +x /root/metricbeat/sbin/*.sh"
done

wait
