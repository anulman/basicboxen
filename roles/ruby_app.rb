name "ruby_app"
description "ruby environment"

run_list(
  "recipe[build-essential]",
  "recipe[rbenv]",
  "recipe[rbenv::ruby_build]",
  "recipe[site-ruby::install_ruby]",
  "recipe[site-libv8::install_libv8_dev]",
  "recipe[rbenv::rbenv_vars]",
)
