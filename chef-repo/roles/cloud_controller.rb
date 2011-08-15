name "cloud_controller"
  description "CloudFoundry controller role"
  run_list(
    "recipe[essentials]",
    "recipe[ruby]",
    "recipe[postgresql]",
    "recipe[mysql::server]",
    "recipe[mysql]",
    "recipe[cloud_controller]"
  )


