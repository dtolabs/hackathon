#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "/var/lib/jenkins/plugins" do
  owner "jenkins"
  group "adm"
end

remote_file "/var/lib/jenkins/plugins/rundeck.hpi" do
  source "http://updates.jenkins-ci.org/latest/rundeck.hpi"
  owner "jenkins"
  group "adm"
end

remote_file "/var/lib/jenkins/plugins/git.hpi" do
  source "http://mirrors.xmission.com/jenkins/plugins/git/latest/git.hpi"
  owner "jenkins"
  group "adm"
end

execute "restart" do
  command "/etc/init.d/jenkins restart"
end



