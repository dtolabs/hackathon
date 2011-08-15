name "rundeck"
  description "Rundeck server and tools"
  run_list(
    "recipe[rundeck]"
  )
  override_attributes(
    :rundeck => {
        :nodename => "rundeck-server",
        :hostname => "ec2-107-20-4-221.compute-1.amazonaws.com",
        :port => "8080"
    }
  )
