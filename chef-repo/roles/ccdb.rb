name "ccdb"
description "Cloudfoundry cloud controller database"
override_attributes()
run_list(
  "recipe[essentials]",
  "recipe[cf-mysql::server]",
  "recipe[cf-mysql]"
)


