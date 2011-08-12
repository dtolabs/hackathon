name "workbench"
  description "workbench and tools node"
  run_list(
    "recipe[essentials]",
    "recipe[ruby]",
    "recipe[postgresql]",
    "recipe[mysql::server]",
    "recipe[mysql]",
    "recipe[cloud_controller]"
  )


