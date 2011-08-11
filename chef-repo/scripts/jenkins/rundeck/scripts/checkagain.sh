#!/bin/bash
# Usage: checkagain.sh [iterations secs port]
iterations=$1; secs=$2 port=$3
echo "port ${port:=8080} will be checked ${iterations:=30} times waiting ${secs:=5}s between each iteration"

i=0
while [ $i -lt ${iterations} ]; do
  echo "iteration: #${i}"
  netstat -an | grep $port | grep LISTEN && exit 0
  echo ----
  sleep ${secs}
  i=$(($i+1))
done
echo "Not listening on $port after $i checks" ; exit 1
