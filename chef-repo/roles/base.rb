name "base"
description "Base role applied to all nodes."
    override_attributes(
      "munin" => {"server_role" => "datacollect"},
      "chef_client" => {"client_interval" => "3600"},
      "chef_client" => {"init_style" => "runit"},
      "authorization" => {
        "sudo" => {
          "passwordless" => true
        }
      },
      "dynect" => {
            "customer" => "demo-dtosolutions",
            "username" => "hackday",
            "password" => "h@ckday",
            "zone" => "dtolabs.com",
            "domain" => "dtolabs.com"
          }
    )
   run_list(
      "recipe[apt]",
      "recipe[users::sysadmins]",
      "recipe[sudo]",
      "recipe[tools]",
      "recipe[runit]",
      "recipe[chef-client::service]",
      "recipe[dynect]",
      "recipe[dynect::ec3]"
)

