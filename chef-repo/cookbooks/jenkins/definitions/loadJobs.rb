define :loadJobs, :jobUrlDir => nil, :username => nil, :password => nil do

   jenkinsServer="localhost:8080"
   MAX_API_TRIES=node[:jenkins][:api][:retries]

   # ensure jenkins rest api is available by iterating until api responds favorably otherwise timeout
   script "assertRestApiAvail" do
      interpreter "bash"
      user "jenkins"
      group "nogroup"
      action :run
      notifies :start, resources(:service => "jenkins"), :immediately
      code <<-EOH
         tries=0
         while [ 1 ]
         do
            if curl  -s -k -f "#{jenkinsServer}/api" 
            then
               break
            fi
            echo "waiting for #{jenkinsServer}/api to respond"
            let tries=tries+1
            if [ $tries -eq #{MAX_API_TRIES} ]
            then
               echo "jenkins startup failed" 1>&2
               exit 1
            fi
            sleep 5
         done
      EOH

   end


   script "loadJobs" do
      interpreter "bash"
      user "jenkins"
      group "nogroup"
      action :run
      code <<-EOH
         configXmlTmpDir=$(mktemp -d)
         svn export --config-dir /var/lib/jenkins/subversionAuthCache --trust-server-cert --non-interactive   #{params[:jobUrlDir]} ${configXmlTmpDir}/jobExport
         cd ${configXmlTmpDir}/jobExport
         for jobXml in *.xml
         do
            jobName=$(echo $jobXml |sed 's/\.xml$//')
            if ! curl  -f  --data /dev/null  -H 'Content-Type: text/xml' -u #{params[:username]}:#{params[:password]} -s http://#{jenkinsServer}/job/${jobName} > /dev/null 2>&1
            then
               curl -f --data "@./${jobXml}" -H "Content-Type: text/xml" -u "#{params[:username]}:#{params[:password]}" "http://#{jenkinsServer}/createItem?name=${jobName}" ||  { echo "error posting jenkins job ${jobName} from #{params[:jobUrlDir]} to #{jenkinsServer}" 1>&2 ; exit 1; }
            fi
         done
         rm -rf ${configXmlTmpDir}
      EOH
   end

end


