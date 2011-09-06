name "health_manager"
description "Cloudfoundry health manager"
run_list(
  "recipe[cf-deployment]",
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[health_manager]"
)