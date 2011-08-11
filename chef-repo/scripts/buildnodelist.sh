export instances=""
    for i in `knife ec2 server list | grep running | grep $RUNDECKID | awk '{print $2}'`
    do
     instances="$instances $i"
    done
echo $instances
export instances
