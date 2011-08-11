#
# Cookbook Name:: chefrundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

gem_package "chef-rundeck" do
  action :install
end

execute "createproject" do
  command "rd-project -p chef-demo --action create"
end

template "#{node[:rundeck][:projdir]}/chef-demo/etc/project.properties" do
  source "chefproject.properties.erb"
  owner "rundeck"
  group "rundeck"
  mode 0755
end

