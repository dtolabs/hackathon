name "cloudfoundry"
description "CloudFoundry components"
run_list(
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[cloudfoundry]"
)


