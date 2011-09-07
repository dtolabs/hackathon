name "ruby"
  description "CloudFoundry Ruby Role"
  run_list(
    "recipe[essentials]",
    "recipe[ruby::ruby18]",
    "recipe[ruby]"
  )


