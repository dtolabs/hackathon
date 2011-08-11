#
# Cookbook Name:: rundeck
# Recipe:: knife
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ libxml2-dev libxslt1-dev }.each do |pkg|
  package pkg
end

gem_package "knife-ec2" do
  action :install
end

