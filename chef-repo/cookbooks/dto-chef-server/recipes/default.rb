#
# Cookbook Name:: chef-server
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"

apt_repository "apt.opscode.com" do
 uri "http://apt.opscode.com"
 components ["natty-0.10 main"]
 key "http://apt.opscode.com/packages@opscode.com.gpg.key"
 action :add
end

execute "preseed chef-server" do
  command "debconf-set-selections /var/cache/local/preseeding/chef-server.seed"
  action :nothing
end

template "/var/cache/local/preseeding/chef-server.seed" do
  source "chef-server.seed.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :run, resources(:execute => "preseed chef-server"), :immediately
end

%w{ chef chef-server }.each do |pkg|
  package pkg
end

