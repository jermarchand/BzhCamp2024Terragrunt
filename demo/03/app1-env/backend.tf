terraform {

  backend "s3" {
    bucket = "tf-backends"
    key    = "app1-env-terraform.tfstate"

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
