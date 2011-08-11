name "datacollect"
  description "munin node"
  run_list(
    "role[production]",
    "role[base]",
    "recipe[munin::server]"
  )


