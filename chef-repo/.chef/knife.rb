log_level                :info
log_location             STDOUT
node_name                'khudgins'
client_key               'khudgins.pem'
validation_client_name   'chef-validator'
validation_key           '.chef/validation.pem'
chef_server_url          'http://chef.dtolabs.com:4000'
cache_type               'BasicFile'
cache_options( :path => '.chef/checksums' )
cookbook_path 					 './cookbooks'
