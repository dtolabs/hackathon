name "monitoring"
  description "nagios node"
  run_list(
    "role[production]",
    "role[base]",
    "recipe[nagios::server]"
)
