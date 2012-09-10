name "blog_runlist"
description 'mriddle blog stack'
run_list(
  "recipe[nginx]",
  "recipe[capistrano]",
  "recipe[rails]"
)