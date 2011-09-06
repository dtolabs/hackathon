name "nats"
description "NATS message bus"
override_attributes()
run_list(
  "recipe[cf-deployment]",
	"recipe[cf-essentials]",
	"recipe[cf-ruby]",
	"recipe[nats_server]"
)
