#!/bin/bash
knife client delete $1 -y
knife node delete $1 -y
#knife ec2 server delete $1 -y
