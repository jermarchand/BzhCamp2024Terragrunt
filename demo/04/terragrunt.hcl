locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = merge(
  local.environment_vars.locals,
)

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "kubernetes" {
  config_path = "~/.kube/config"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {

  backend "s3" {
    bucket = "tf-backends"
    key    = "${path_relative_to_include()}/app1-env-terraform.tfstate"

    endpoints = {
      s3 = "http://minio-ui.test"
    }

    # ~/.aws/credentials
    # access_key = "FLVqceSq1cv7YgOS"
    # secret_key = "tGb5kZGn7B3VcKfyGnaLiqbtPjlwFXPm"

    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}

EOF
}
