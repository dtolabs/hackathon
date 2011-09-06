name "cf-postgresql"
description "Postgresql db for apps"
override_attributes()
run_list(
  "recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-postgresql]",
	"role[cf-services]"
)
