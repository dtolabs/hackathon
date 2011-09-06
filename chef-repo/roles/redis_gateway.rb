name "redis_gateway"
description "Redis services gateway"
run_list(
	"recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-redis::gateway]"
)
