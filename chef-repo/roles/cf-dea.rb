name "cf-dea"
description "CloudFoundry DEA role"
run_list(
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[cf-ruby::ruby18]",
  "recipe[dea]",
  "recipe[cf-nodejs]",
  "recipe[cf-erlang]",
  "recipe[cf-java]"
)
  


