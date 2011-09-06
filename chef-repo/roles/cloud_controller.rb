name "cloud_controller"
  description "CloudFoundry controller role"
  run_list(
    "recipe[cf-essentials]",
    "recipe[cf-ruby]",
    "recipe[cf-postgresql]",
    "recipe[cf-mysql::server]",
    "recipe[cf-mysql]",
    "recipe[cloud_controller]"
  )


