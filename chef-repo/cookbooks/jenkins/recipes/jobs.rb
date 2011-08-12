#
# Cookbook Name:: jenkins
# Recipe:: jobs-xfabric
#

jenkinsUsername="chuck"
jenkinsPassword="vfr50000"


credentialEntries="#{node[:jenkins][:scm][:subversion][:credentialEntries]}"



scmUrl = node[:jenkins][:scmUrl]
jobSyncSCMRepo = node[:jenkins][:jobSyncSCMRepo]

ciJobsUrl = "#{scmUrl}/#{jobSyncSCMRepo}"


template "/var/lib/jenkins/hudson.scm.SubversionSCM.xml" do
  source "var/lib/jenkins/hudson.scm.SubversionSCM.xml.erb"
  mode 0644
  owner "jenkins"
  group "nogroup"
  variables({
     :credentialEntries => credentialEntries
  })
end

loadJobs "loadJobs" do
   jobUrlDir ciJobsUrl
   username jenkinsUsername
   password jenkinsPassword
end
