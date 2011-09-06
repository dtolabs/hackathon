name "cloudfoundry"
description "CloudFoundry components"
run_list(
  "recipe[cf-deployment]",
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[cloudfoundry]"
)


