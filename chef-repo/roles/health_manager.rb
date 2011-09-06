name "health_manager"
description "Cloudfoundry health manager"
run_list(
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[cf-health_manager]"
)