name "workbench"
  description "workbench and tools node"
  run_list(
    "role[production]",
    "role[base_no]",
    "recipe[ec2tools]",
    "recipe[rundeck]",
    "recipe[rundeck::knife]",
    "recipe[rundeck::dto]",
    "recipe[rundeck::awsdeck]",
    "recipe[rundeck::chefdeck]"
  )


