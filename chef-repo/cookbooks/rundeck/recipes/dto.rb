#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "#{node[:rundeck][:homedir]}/.ssh/id_rsa" do
  source "rundeck-demo.pem"
  owner "rundeck"
  group "rundeck"
  mode "0600"
end

cookbook_file "#{node[:rundeck][:homedir]}/.bashrc" do
  source "dotbashrc"
  owner "rundeck"
  group "rundeck"
  mode "0755"
end

cookbook_file "#{node[:rundeck][:homedir]}/dotchef.tar" do
  source "dotchef.tar"
  owner "rundeck"
  group "rundeck"
  mode "0755"
end

execute "tar1" do
  cwd "#{node[:rundeck][:homedir]}"
  command "tar -xvf dotchef.tar"
  creates "#{node[:rundeck][:homedir]}/.chef/dotbashrc"
end

cookbook_file "#{node[:rundeck][:homedir]}/scripts.tar" do
  source "scripts.tar"
  owner "rundeck"
  group "rundeck"
  mode "0755"
end

execute "tar2" do
  cwd "#{node[:rundeck][:homedir]}"
  command "tar -xvf scripts.tar"
  creates "#{node[:rundeck][:homedir]}/scripts/wp1.sh"
end


