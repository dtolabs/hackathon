name "mysql_gateway"
description "MySQL services gateway"
run_list(
	"recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-mysql::gateway]"
)
