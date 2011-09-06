name "cloud_controller"
  description "CloudFoundry controller role"
  run_list(
    "recipe[cf-deployment]",
    "recipe[cf-essentials]",
    "recipe[cf-ruby]",
    "recipe[cf-ruby::ruby18]",
    "recipe[ccdb]",
    "recipe[cloud_controller]"
  )


