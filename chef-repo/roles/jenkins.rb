name "jenkins"
  description "workbench and tools node"
  run_list(
    "role[production]",
    "role[base_no]",
    "recipe[jenkins]",
    "recipe[jenkins::plugins]"
  )


