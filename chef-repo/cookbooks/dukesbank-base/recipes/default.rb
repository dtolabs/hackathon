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
  gid "users"
  shell "/bin/bash"
  home "/home/demo"
end

group "wheel" do
  gid 51
  members ['demo', 'ubuntu']
end

# Sudoers, so demo user can run root commands:
template "/etc/sudoers" do
  source "sudoers.erb"
  owner "root"
  group "root"
  mode 0440
end

if platform?("debian", "ubuntu")
  template "/etc/ssh/sshd_config" do
    source "sshd_config.erb"
    owner "root"
    group "root"
    mode 0644
  end
end
