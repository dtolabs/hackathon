echo "**** Status Nodes ***"
knife status --run-list | grep dtolabs 
echo "**** EC2 Nodes ***"
knife ec2 server list  | grep dtolabs| grep running

