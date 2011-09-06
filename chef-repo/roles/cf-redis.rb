name "cf-redis"
description "Redis key value store for apps"
override_attributes()
run_list(
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-redis]",
	"role[cf-services]"
)
