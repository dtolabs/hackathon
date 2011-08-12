name "cf-router"
  description "CloudFoundry Router Role"
  run_list(
    "recipe[essentials]",
    "recipe[ruby]",
    "recipe[nginx]",
    "recipe[router]"
  )


