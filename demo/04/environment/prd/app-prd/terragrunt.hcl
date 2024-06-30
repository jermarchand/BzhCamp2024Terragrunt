terraform {
  source = "${get_parent_terragrunt_dir()}//modules/app1-env"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  service_port = 30205
}
