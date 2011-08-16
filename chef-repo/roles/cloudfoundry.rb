name "cloudfoundry"
  description "CloudFoundry components"
  run_list(
    "recipe[essentials]",
    "recipe[ruby]",
    "recipe[cloudfoundry]",
    "role[base]", 
    "role[cf-attributes]",
    "role[cloudfoundry]",
    "role[cf-router]", 
    "role[cloud_controller]",
    "role[cf-dea]", 
    "recipe[health_manager]", 
    "recipe[services]"
  )


