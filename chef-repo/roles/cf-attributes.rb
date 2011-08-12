name "cf-attributes"
  description "CloudFoundry Attributes Dummy Role"
  override_attributes(
    :apache2 => {
      :prefork => { :min_spareservers => "5" }
    },
    :tomcat => {
      :worker_threads => "100"
    },
    :mongodb => {
        :version => "1.8.1",
        :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/mongodb"
    },
    :cloudfoundry => {
      :path => "/home/ubuntu/.cloudfoundry/devbox/vcap",
      :revision => "HEAD"
    },
    :mysql => {
      :server_repl_password => "root",
      :bind_address => "127.0.0.1",
      :server_root_password => "root"
    },
    :nodejs => { 
      :version => "0.4.8",
      :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/nodejs"
    },
    :nginx => {
      :vcap_log => "/home/ubuntu/.cloudfoundry/devbox/sys/log/vcap.access.log"
    },
    :ruby18 => {
      :version => "1.8.7-p334",
      :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/rubies/ruby-1.8.7-p334"
    },
  	:services => ["redis","mysql","mongodb","postgresql"],
  	:rubygems => {
  		  :rake => {:version => "0.8.7"},
  		:version => "1.5.2",
  		:bundler => {:version => "1.0.10"}
  	},
  	:ruby => {
  	  :version => "1.9.2-p180",
  	  :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/rubies/ruby-1.9.2-p180"
  	},
  	:deployment => {
  		:group => "1000",
  		:name => "devbox",
  		:config_path => "/home/ubuntu/.cloudfoundry/devbox/config",
  		:user => "ubuntu",
  		:home => "/home/ubuntu/.cloudfoundry/devbox"
  	},
  	:erlang => {
  	  :version => "R14B02",
  	  :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/erlang"
  	},
  	:postgresql => {:server_root_password => "root"},
  	:redis => {
  	  :runner => "ubuntu",
  	  :version => "2.2.4",
  	  :path => "/home/ubuntu/.cloudfoundry/devbox/deploy/redis"
  	}


  
  )


