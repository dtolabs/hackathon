default[:rundeck][:dir] = "/var/lib/rundeck"
default[:rundeck][:projdir] = "/var/lib/rundeck/projects"
default[:rundeck][:port] = "4440"
default[:rundeck][:web][:context] = ""
default[:rundeck][:hostname]=node[:ipaddress]
default[:rundeck][:nodename]=node[:fqdn]