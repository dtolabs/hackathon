name "cf-mongodb"
description "Cloudfoundry mongodb"
override_attributes()
run_list(
  "recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-mongodb]",
	"role[cf-services]"
)
