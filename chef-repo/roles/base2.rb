name "base2"
description "Base role applied to all nodes."
override_attributes(
  "munin" => {"server_role" => "datacollect"},
  "chef_client" => {"client_interval" => "3600"},
  "chef_client" => {"init_style" => "runit"},
  "authorization" => {
    "sudo" => {
      "passwordless" => true
    }
  }
)
run_list(
      "recipe[apt]",
      "recipe[users::sysadmins]",
      "recipe[sudo]",
      "recipe[tools]",
      "recipe[runit]"
)

