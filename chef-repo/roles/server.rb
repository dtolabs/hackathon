name "server"
  description "workbench and tools node"
  run_list(
    "role[production]",
    "role[base]"
  )


