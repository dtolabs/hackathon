name "cf-services"
description "Cloudfoundry services"
override_attributes()
run_list(
  "recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cloudfoundry]",
	"recipe[cf-services]"
)
