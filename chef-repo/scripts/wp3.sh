# Start 
#
if [[ $1 == '' ]]
then
echo -n "Role: "
  read role 
else
role=$1
fi

if [[ $2 == '' ]]
then
echo -n "Instance: "
  read instance 
else
instance=$2
fi

nodeid=dto-$role-$instance
echo "Starting AWS Instance for node " $nodeid

#lucid32
knife ec2 server create -r "role[$RUNDECKID],role[$role]" -f c1.medium -I ami-2cc83145 -G default,rundeck-demo -S $RUNDECKID -x ubuntu -N $nodeid 


