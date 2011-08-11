#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java"

remote_file "#{node[:rundeck][:dir]}/rundeck-launcher-1.3.0.jar" do
  source "https://github.com/downloads/dtolabs/rundeck/rundeck-launcher-1.3.0.jar"
  owner "rundeck"
  group "sysadmin"
  mode "0644"
end

execute "install" do
  cwd "#{node[:rundeck][:dir]}"
  command "java -jar #{node[:rundeck][:dir]}/rundeck-launcher-1.3.0.jar --install-only -b #{node[:rundeck][:dir]}"
  creates "#{node[:rundeck][:dir]}/server"
end

template "/etc/security/limits.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode 0755
end

execute "copy-init" do
  command "cp #{node[:rundeck][:dir]}/server/sbin/rundeckd /etc/init.d/rundeckd"
  not_if {File.exists?("/etc/init.d/rundeckd")}
end

service "rundeckd" do
  supports :status => true, :restart => true, :stop=> true, :start=>true
  action [:enable,:start]
end
