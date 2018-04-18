#!/usr/bin/env bash

bin=`dirname "$this"`
bin=`cd "$bin"; pwd`
export SERVERLIST="${bin}/serverlist/serverlist_$1"

for server in `cat "$SERVERLIST"`; do
  # Print server
  echo $server;

  # rsync
  rsync -av metricbeat-6.1.4-linux-x86_64 root@$server:~/;

  # make symbolic link
  ssh $server "ln -s /root/metricbeat-6.1.4-linux-x86_64 /root/metricbeat"

  # copy metricbeat.yml forcefully
  scp -r config/metricbeat.yml root@$server:~/metricbeat;

  # copy sbin for script execution
  scp -r sbin root@$server:~/metricbeat;

  # change owner to root
  ssh $server "chown -R root /root/metricbeat-6.1.4-linux-x86_64"

  # add exec permmision to scripts
  ssh $server "chmod +x /root/metricbeat/sbin/*.sh"

  # add extended module config and enable the module
  if [ "$2" == "zookeeper" ]; then
    ssh $server "rm -rf /root/metricbeat/modules.d/zookeeper*"
    scp -r config/modules.d/zookeeper.yml.disabled root@$server:~/metricbeat/modules.d/;
    ssh $server "cd ~/metricbeat/ && ./metricbeat modules enable zookeeper"
  elif [ "$2" == "kafka" ]; then
        ssh $server "rm -rf /root/metricbeat/modules.d/kafka*"
        scp -r config/modules.d/kafka.yml.disabled root@$server:~/metricbeat/modules.d/;
        ssh $server "cd ~/metricbeat/ && ./metricbeat modules enable kafka"
  fi

done

wait
