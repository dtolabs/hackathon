name "chef-server"
  description "chef server node"
  run_list(
    "role[production]",
    "role[base]",
    "recipe[chef-server]",
    "recipe[chef-server::config]"
  )


