locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = merge(
  local.environment_vars.locals,
)

generate "provider" {
}

