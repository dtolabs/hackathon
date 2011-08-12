#
# JENKINS CONFIGURATION
#    jenkins version we are installing
default[:jenkins][:version] = "1.424"

#
# Subversion Bootstrap Configuration
#
#    Retries to attempt when bootstrapping jobs from subversion.  During the bootstrapping of the jenkins service we want to ensure the jenins api is up and ready to receive requests.
#    This may take some time, so there is an interation loop that will ensure this service is up before jobs are loaded over REST api, 15 maximum seems to be reasonable (5 secs in between tries)
default[:jenkins][:api][:retries] = "15"
#

#
# RUNDECK PLUGIN CONFIGURATION (currently not being used) 
#
default[:jenkins][:plugins][:rundeck][:version] = "2.5"
default[:jenkins][:plugins][:rundeck][:url] = "http://192.168.63.132:4440"
default[:jenkins][:plugins][:rundeck][:user] = "admin"
default[:jenkins][:plugins][:rundeck][:password] = "admin"
