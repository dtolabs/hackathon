name "ganglia-server"
  description "Ganglie Server Role"
  run_list(
    "recipe[apache2]",
    "recipe[ganglia::client]",
    "recipe[ganglia::server]"
)
