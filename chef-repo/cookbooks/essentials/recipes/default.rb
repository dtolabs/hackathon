#
# Cookbook Name:: essentials
# Recipe:: default
#
# Copyright 2011, VMWARE
#
#
%w{apt-utils wget curl libcurl3 bison build-essential zlib1g-dev libssl-dev
   libreadline5-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev git-core sqlite3 libsqlite3-ruby
   libsqlite3-dev unzip zip ruby-dev libmysql-ruby libmysqlclient-dev libcurl4-openssl-dev}.each do |p|
  package p do
    action [:install]
  end
end

directory node[:deployment][:config_path] do
  owner node[:deployment][:user]
  group node[:deployment][:group]
  mode "0755"
  recursive true
  action :create
end

directory File.join(node[:deployment][:config_path], "staging") do
  owner node[:deployment][:user]
  group node[:deployment][:group]
  mode "0755"
  recursive true
  action :create
end

#HACK FIXME: these guys need to not be hardcoded, especially the deployment userdir stuff

%w{/var/vcap/db /var/vcap/sys /var/vcap/sys/log /var/vcap/data/cloud_controller/tmp /var/vcap/data/db /var/vcap.local/staging /home/hackday/.cloudfoundry/devbox/sys /home/hackday/.cloudfoundry/devbox/sys/log/}.each do |d|
  directory d do
    owner node[:deployment][:user]
    group node[:deployment][:group]
    mode "0755"
    recursive true
    action :create
  end
end

#We also need to add ruby 1.9's bin path to the *beginning* of the deployment user's path:
template "/home/#{node[:deployment][:user]}/.profile" do
  source "profile.erb"
  owner node[:deployment][:user]
  group node[:deployment][:group]
  mode "0755"
end