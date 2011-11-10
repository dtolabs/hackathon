include_recipe "apache2::default"
include_recipe "apache2::mod_dav_svn"

directory "/var/www/svn" do
  owner "root"
  mode 0755
end

service "apache2" do
  action :nothing
  supports :reload => true, :restart => true, :status => true
end

webuser = ""
case node[:platform]
when "CentOS","RedHat","Fedora"
  webuser = "apache"
else
  webuser = "www-data"
end

script "build svn repo" do
  user "root"
  interpreter "bash"
  cwd "/var/www/svn"
  code <<-EOH
  svnadmin create dukesbank
  chown -R #{webuser}.#{webuser} dukesbank
  EOH
  not_if "test -f /var/www/svn/dukesbank/format"
end

script "create htpasswd file" do
  user "root"
  interpreter "bash"
  code "htpasswd -cb /etc/svn-auth-file build build"
  not_if "test -f /etc/svn-auth-file"
end

template "/etc/apache2/sites-available/svn" do
  source "svn.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

script "enable svnsite" do
user "root"
  user "root"
  interpreter "bash"
  code "a2ensite svn"
  only_if "test -f /etc/apache2/sites-available/svn"
  notifies :reload, "service[apache2]"
end


include_recipe "jboss"

include_recipe "jenkins"

include_recipe "rundeck"
