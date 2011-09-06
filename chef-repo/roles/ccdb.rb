name "ccdb"
description "Cloudfoundry cloud controller database"
override_attributes()
run_list(
  "recipe[cf-deployment]",
  "recipe[postgresql]",
  "recipe[ccdb]"
)


