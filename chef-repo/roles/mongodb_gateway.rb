name "mongodb_gateway"
description "Mongodb Gateway"
run_list(
	"recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-mongodb::gateway]"
)

