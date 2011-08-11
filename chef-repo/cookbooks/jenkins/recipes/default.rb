#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"

package "ant" do
  action :install
end

apt_repository "jenkins" do
 uri "http://pkg.jenkins-ci.org/debian"
 components ["binary/"]
 key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
 action :add
end

package "jenkins" do
  action :install
end
