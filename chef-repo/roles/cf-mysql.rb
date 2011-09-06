name "cf-mysql"
description "mysql db for apps"
override_attributes()
run_list(
  "recipe[cf-deployment]",
  "recipe[cf-essentials]",
  "recipe[cf-ruby]",
  "recipe[cf-mysql]",
  "recipe[cf-mysql::node]"
)

