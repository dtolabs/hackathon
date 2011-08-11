#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java"

directory "#{node[:rundeck][:dir]}" do
  owner "rundeck"
  group "sysadmin"
  mode "0755"
  action :create
end

remote_file "#{node[:rundeck][:dir]}/rundeck-launcher-1.2.0.jar" do
  source "https://github.com/downloads/dtolabs/rundeck/rundeck-launcher-1.2.0.jar"
  owner "rundeck"
  group "sysadmin"
  mode "0644"
end

cookbook_file "/home/rundeck/.ssh/id_rsa" do
  source "rundeck-demo.pem"
  owner "rundeck"
  group "sysadmin"
  mode "0600"
end

template "/etc/security/limits.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode 0755
end

template "#{node[:rundeck][:dir]}/runonce.sh" do
  source "runonce.sh.erb"
  owner "rundeck"
  group "sysadmin"
  mode 0755
end

template "#{node[:rundeck][:dir]}/rundeck.sh" do
  source "rundeck.sh.erb"
  owner "rundeck"
  group "sysadmin"
  mode 0755
end


