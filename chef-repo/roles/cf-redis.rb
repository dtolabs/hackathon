name "cf-redis"
description "Redis key value store for apps"
override_attributes()
run_list(
  "recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-redis]",
	"recipe[cf-redis::node]"
)
