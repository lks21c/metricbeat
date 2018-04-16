for i in mpcollect01 mpcollect02 mpcollect03 ;
  do
    echo $i;
    rsync -av metricbeat-6.1.4-linux-x86_64 root@$i:~/;
    ssh $i "ln -s /root/metricbeat-6.1.4-linux-x86_64 /root/metricbeat"
    scp -r config/metricbeat.yml root@$i:~/metricbeat;
    scp -r sbin root@$i:~/metricbeat;
    ssh $i "chmod +x /root/metricbeat/sbin/*.sh"
done


for i in mpalyes01 mpalyes02 mpalyes03 mpalyes04 mpalyes05 mpalyes06 mpalyes07 mpalyes08 mpalyes09 mpalyes10 mpalyes11 mpalyes12 mpalyes13 mpalyes14;
  do
    echo $i;
    rsync -av metricbeat-6.1.4-linux-x86_64 root@$i:~/;
    ssh $i "ln -s /root/metricbeat-6.1.4-linux-x86_64 /root/metricbeat"
    scp -r config/metricbeat.yml root@$i:~/metricbeat;
    scp -r sbin root@$i:~/metricbeat;
    ssh $i "chmod +x /root/metricbeat/sbin/*.sh"
done
