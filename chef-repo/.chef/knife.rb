log_level                :info
log_location             STDOUT
node_name                'khudgins'
client_key               '/Volumes/Storage/Projects/dto/hackfest/hackathon/chef-repo/.chef/khudgins.pem'
validation_client_name   'chef-validator'
validation_key           '.chef/validation.pem'
chef_server_url          'http://chef.dtolabs.com:4000'
cache_type               'BasicFile'
cache_options( :path => '/Volumes/Storage/Projects/dto/hackfest/hackathon/chef-repo/.chef/checksums' )
