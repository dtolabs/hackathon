name "ganglia-server"
  description "Ganglie Server Role"
  run_list(
    "role[ganglia::client]",
    "role[ganglia::server]"
)
