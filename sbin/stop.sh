#kill $(ps aux | grep 'metricbeat'| awk '{print $2}') >/dev/null 2>&1 &
pkill metricbeat

