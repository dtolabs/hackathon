name "jenkins"
  description "workbench and tools node"
  run_list(
    "recipe[jenkins]",
    "recipe[jenkins::plugins]"
  )


