#
# Cookbook Name:: config
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
script "config-dot-chef" do
  interpreter "bash"
  user "root"
  cwd "/home/ubuntu"
  code <<-EOH
  mkdir -p ~/.chef
  cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
  chown -R ubuntu:ubuntu ~/.chef
  EOH
end
