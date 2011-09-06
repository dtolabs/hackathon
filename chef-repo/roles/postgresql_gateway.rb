name "postgresql_gateway"
description "PostgreSQL services gateway"
run_list(
	"role[cf-services]"
)
default_attributes(
  "services" => [ "postgresql" ],
  "service_components" => ["postgresql_gateway"]
)
