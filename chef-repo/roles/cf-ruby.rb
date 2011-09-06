name "cf-ruby"
  description "CloudFoundry Ruby Role"
  run_list(
    "recipe[cf-essentials]",
    "recipe[cf-ruby::ruby18]",
    "recipe[cf-ruby]"
  )


