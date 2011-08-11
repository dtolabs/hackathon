#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "openjdk-6-jdk" do
  action :install
end

remote_file "/tmp/rundeck-1.3.0-0.deb" do
  source "http://build.rundeck.org/job/rundeck-development/lastSuccessfulBuild/artifact/packaging/rundeck-1.3.0-0.deb"
  owner "rundeck"
  group "sysadmin"
  mode "0644"
end

package "rundeck" do
  action :install
  source "/tmp/rundeck-1.3.0-0.deb"
  provider Chef::Provider::Package::Dpkg
end

service "rundeckd" do
# provider Chef::Provider::Service::Upstart
  action [:enable,:start]
end

execute "chmod1" do
  command "chmod -R 777 /var/lib/rundeck"
  action :run
end

execute "chmod2" do
  command "chmod -R 777 /var/log/rundeck"
  action :run
end

execute "chmod3" do
  command "chmod -R 777 /var/rundeck"
  action :run
end
