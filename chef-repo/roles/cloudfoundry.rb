name "cloudfoundry"
  description "CloudFoundry components"
  run_list(
    "recipe[essentials]",
    "recipe[ruby]",
    "recipe[cloudfoundry]"
  )


