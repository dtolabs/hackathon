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



# Get args. Need hostnames of boxes to launch. First is chef server, second is
# starting node number, third is ending node number.
# Important to get these right, or we'll clobber dns as we go.
unless ARGV.length == 3 && ARGV[1] <= ARGV[2]
  puts "Usage: setup_env.rb N X Y"
  puts "chefN = chef node, ie: chef1, chef2, etc"
  puts "X = start node number"
  puts "Y = end node number"
  puts "This will create a chef server node, chef N"
  puts "and hackX.dtolabs.com through hackY.dtolabs.com"
  exit
end

chefnode = ARGV[0]
nodeX = ARGV[1].to_i
nodeY = ARGV[2].to_i
number_of_nodes = nodeY - nodeX + 1



# Use default security group, it's ready to go. Otherwise, we'd have to open it up.

# Start the chef server

# Prep the userdata file
hostname = "chef#{chefnode}"
fqdn = "chef#{chefnode}.dtolabs.com"
userdata_file = File.read('bootstrap_chef_server.sh.erb')
eruby = Erubis::Eruby.new(userdata_file)
userdata = eruby.result(:hostname => hostname, :fqdn => fqdn)
chef = ec2.servers.create(:image_id => ami,
                            :key_name => key_name,
                            :flavor_id => instance_size,
                            :user_data => userdata
)

print "Launching #{fqdn}: "
puts chef.wait_for{ 
  print "."
  ready? 
}
puts "---------------------------------------------"
puts "Chef server instance id: " + chef.id
puts "Chef server IP: #{chef.public_ip_address}"
puts "Chef server ec2 DNS: #{chef.dns_name}"

# Set up knife and upload cookbooks
# Run chef-client on chef server
# This step done w/ userdata. That bit works well.


# Do DNS data for server:
# Set up ssh creds:
chef.username = AWS_USERNAME
chef.private_key_path = AWS_PATH_TO_KEY

set_cname(dynect, DYNECT_ZONE, fqdn, chef.dns_name)
# Wait 60 seconds for the box to boot... important
sleep(60)
chef.ssh("touch /tmp/fog_was_here")
# K, all working. Now we should pull http on server:4040 in a loop until we know the chef server is running, and
# then start the other boxes.
# Or, just put in a 10 minute sleep? Dunno. Need to time it.
# Start up the other VMs
chef.wait_for{ chef.ssh('[ -e ~/.chef/validation.pem ]').first.status == 0 }

validator = chef.ssh('sudo cat ~/.chef/validation.pem').first
File.open("tmp/#{fqdn}.validation.pem", 'w') {|f| f.write(validator.stdout)}
# bootstrap 'em
