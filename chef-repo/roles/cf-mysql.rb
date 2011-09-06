name "cf-mysql"
description "mysql db for apps"
override_attributes()
run_list(
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[cf-mysql::server]",
	"recipe[cf-mysql]",
	"role[cf-services]"
)

