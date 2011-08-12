#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java"

#package "openjdk-6-jdk" do
#  action :install
#end

group "rundeck" do
  gid 2040
end

user "rundeck" do
  comment "Rundeck User"
  uid "2040"
  gid "rundeck"
  home "#{node[:rundeck][:dir]}"
  shell "/bin/bash"
end

directory "#{node[:rundeck][:dir]}" do
  owner "rundeck"
  group "sysadmin"
  mode "0755"
  action :create
end

remote_file "#{node[:rundeck][:dir]}/rundeck-launcher-1.3.0.jar" do
  source "http://build.rundeck.org/job/rundeck-development/lastSuccessfulBuild/artifact/rundeckapp/target/rundeck-launcher-1.3.0.jar"
  owner "rundeck"
  group "sysadmin"
  mode "0644"
end

template "/etc/security/limits.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode 0755
end

#execute "sysctl" do
#  command "sysctl -p"
#end

execute "install" do
  user "rundeck"
  group "sysadmin"
  cwd "#{node[:rundeck][:dir]}"
  command "java -jar #{node[:rundeck][:dir]}/rundeck-launcher-1.3.0.jar -d --installonly -b #{node[:rundeck][:dir]}"
  #creates "#{node[:rundeck][:dir]}/server"
  #creates "#{node[:rundeck][:dir]}/tools"
  ##creates "#{node[:rundeck][:dir]}/libext"
  #creates "#{node[:rundeck][:dir]}/docs"
end

execute "configure" do
  user "rundeck"
  group "sysadmin"
  cwd "#{node[:rundeck][:dir]}"
  environment ({ 
    "RDECK_BASE" => node[:rundeck][:dir], 
    "RDECK_HOME" => node[:rundeck][:dir], 
    "JAVA_HOME" => node[:java][:java_home] 
    })
  command "#{node[:rundeck][:dir]}/tools/bin/rd-setup -n #{node[:rundeck][:nodename]} -N #{node[:rundeck][:hostname]} -s #{node[:rundeck][:hostname]} --framework.server.port=#{node[:rundeck][:port]}"
  #creates "#{node[:rundeck][:dir]}/server"
  #creates "#{node[:rundeck][:dir]}/tools"
  ##creates "#{node[:rundeck][:dir]}/libext"
  #creates "#{node[:rundeck][:dir]}/docs"
end

#execute "copy-init" do
#  command "cp #{node[:rundeck][:dir]}/server/sbin/rundeckd /etc/init.d/rundeckd"
#  not_if {File.exists?("/etc/init.d/rundeckd")}
#end


template "#{node[:rundeck][:dir]}/server/config/rundeck-config.properties" do
  source "rundeck-config.properties.erb"
  owner "root"
  group "root"
  mode 0755
end

template "/etc/init.d/rundeckd" do
  source "rundeckd.erb"
  owner "root"
  group "root"
  mode 0755
end

service "rundeckd" do
  supports :status => true, :restart => true, :stop=> true, :start=>true
#  action [:enable]
    action [:enable,:start]
end
