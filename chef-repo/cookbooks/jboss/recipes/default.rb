#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

remote_file "/opt/jboss-4.0.3SP1.zip" do
  source "http://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.0.3SP1/jboss-4.0.3SP1.zip/download"
  owner "root"
  checksum "f01d46bfca069b05596f4eab9f29394ad73e604ec7b773f1dd775073699be7a9"
end

script "install jboss" do
  interpreter "bash"
  user "root"
  cwd "/opt"
  code <<-EOH
  unzip -q jboss-4.0.3SP1.zip
  EOH
  not_if "test -f /opt/jboss-4.0.3SP1/jar-versions.xml"
end
