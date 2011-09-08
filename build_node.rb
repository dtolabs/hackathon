#!/usr/bin/ruby

require 'rubygems'
require 'fog'
require 'erubis'

# Credentials... this needs to be abstracted away into a config file for security
# We're using EC2. This should easily be extractable into another IaaS provider
# As long as fog supports it.

require 'lib/dns.rb'
require 'env_config.rb'

# fog api object instantiation. We'll pass these guys into things later.

ec2 = Fog::Compute.new({
  :provider => 'AWS', 
  :aws_access_key_id => ACCESS_KEY_ID, 
  :aws_secret_access_key => SECRET_ACCESS_KEY
})

dynect = Fog::DNS.new({
  :provider => 'Dynect',
  :dynect_customer => DYNECT_CUSTOMER,
  :dynect_username => DYNECT_USERNAME,
  :dynect_password => DYNECT_PASSWORD
})

#puts ARGV[1]
#puts ARGV[2]
#puts ARGV.length
#puts ARGV[1] <= ARGV[2]

# Get args. Need hostnames of boxes to launch. First is chef server, second is
# starting node number, third is ending node number.
# Important to get these right, or we'll clobber dns as we go.
#unless ARGV.length == 3 && ARGV[1] <= ARGV[2]
#  puts "Usage: setup_env.rb chef_server_instance_id X Y"
#  puts "X = start node number"
#  puts "Y = end node number"
#  puts "This will create a chef server node, chef N"
#  puts "and hackX.dtolabs.com through hackY.dtolabs.com"
#  exit
#end

chefnode = ARGV[0]
nodeX = ARGV[1].to_i
nodeY = ARGV[2].to_i
number_of_nodes = nodeY - nodeX + 1



# Use default security group, it's ready to go. Otherwise, we'd have to open it up.

# Who is our chef server
chef = ec2.servers.get(chefnode)
chef.username = AWS_USERNAME
chef.private_key_path = AWS_PATH_TO_KEY
validator = chef.ssh('sudo cat /etc/chef/validation.pem').first
chef_server_hostname = chef.ssh('hostname').first.stdout.chomp
chef_server_ec2_hostname = chef.dns_name

# Prep the userdata file
hostname = "hack#{nodeX}"
fqdn = "hack#{nodeX}.dtolabs.com"
userdata_file = File.read('bootstrap_chef_client.sh.erb')
eruby = Erubis::Eruby.new(userdata_file)
userdata = eruby.result(:hostname => hostname, :fqdn => fqdn, :target_server => chef_server_ec2_hostname)
node = ec2.servers.create(:image_id => @ami,
                            :key_name => @key_name,
                            :flavor_id => @instance_size,
                            :user_data => userdata
)

print "Launching #{fqdn}: "
node.wait_for{ ready? }
puts "---------------------------------------------"
puts "Chef client instance id: " + node.id
puts "Chef client IP: #{node.public_ip_address}"
puts "Chef client ec2 DNS: #{node.dns_name}"

# Set up knife and upload cookbooks
# Run chef-client on chef server
# This step done w/ userdata. That bit works well.


# Do DNS data for server:
# Set up ssh creds:
node.username = AWS_USERNAME
node.private_key_path = AWS_PATH_TO_KEY

set_cname(dynect, DYNECT_ZONE, fqdn, node.dns_name)
# Wait 60 seconds for the box to boot... important
sleep(60)
node.ssh("touch /tmp/fog_was_here")
output = ""
node.wait_for{ node.ssh("ls /home/ubuntu/.chef").first.status == 0 }

sleep(60)
puts "Node up, chef client is installed"
puts node.ssh("mkdir /home/ubuntu/.chef").first.stdout
node.scp("tmp/#{chef_server_hostname}.validation.pem", '/home/ubuntu/.chef/validation.pem')
node.ssh("sudo cp /home/ubuntu/.chef/validation.pem /etc/chef/validation.pem")
node.ssh("sudo chef-client")
