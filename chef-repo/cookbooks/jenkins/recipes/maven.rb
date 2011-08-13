mavenVersion = node[:jenkins][:maven][:version]
mavenRepoId = node[:jenkins][:maven][:repository][:server][:id]
mavenRepoUsername = node[:jenkins][:maven][:repository][:server][:username]
mavenRepoPassword = node[:jenkins][:maven][:repository][:server][:password]


template "/var/lib/jenkins/tools/maven#{mavenVersion}/conf/settings.xml" do
  source "var/lib/jenkins/tools/maven#{mavenVersion}/conf/settings.xml.erb"
  mode 0644
  owner "jenkins"
  group "nogroup"
  variables({
     :id => mavenRepoId,
     :username => mavenRepoUsername,
     :password => mavenRepoPassword
  })
end

template "/var/lib/jenkins/hudson.tasks.Maven.xml" do
  source "var/lib/jenkins/hudson.tasks.Maven.xml.erb"
  mode 0644
  owner "jenkins"
  group "nogroup"
  variables({
     :version => mavenVersion
  })
end
