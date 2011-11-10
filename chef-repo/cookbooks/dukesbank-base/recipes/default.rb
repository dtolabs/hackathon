#
# Cookbook Name:: dukebank-base
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "demo" do
  password "$1$w8x2QGiv$RLdrT87/8Z29QejUXUYOB0" #dukesbank
  comment "Demo user"
  uid 1001
  gid "admin"
  shell "/bin/bash"
  home "/home/demo"
end

if platform?("debian", "ubuntu")
  service "ssh" do
   supports :restart => true, :status => true, :reload => true
   action :nothing
  end

  template "/etc/ssh/sshd_config" do
    source "sshd_config.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, "service[ssh]" 
  end
end

%w[ unzip subversion ].each do |pkg|
  package pkg
end

include_recipe "java"
