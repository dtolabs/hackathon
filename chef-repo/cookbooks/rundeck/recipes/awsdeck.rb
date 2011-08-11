#
# Cookbook Name:: rundeck
# Recipe:: awsdeck
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "apache2"

template "/var/www/index.html" do
  source "index.html.erb"
  owner "root"
  group "root"
  mode "0644"
end

execute "createproject" do
  command "rd-project -p aws-demo --action create"
end

template "#{node[:rundeck][:projdir]}/aws-demo/etc/project.properties" do
  source "awsproject.properties.erb"
  owner "rundeck"
  group "rundeck"
  mode 0755
end

cookbook_file "/tmp/awsdeck.tar" do
  source "awsdeck.tar"
  owner "rundeck"
  group "rundeck"
  mode "0755"
end

execute "tar1" do
  cwd "/usr/lib/"
  command "tar -xvf /tmp/awsdeck.tar"
end

execute "tar1" do
  command "/etc/init.d/apache2 restart"
end

execute "chmod3" do
  command "chmod -R 777 /var/rundeck/projects"
  action :run
end

%w{ xmlstarlet }.each do |pkg|
  package pkg
end






