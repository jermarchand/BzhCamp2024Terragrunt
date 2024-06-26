terraform {
  source = "${get_parent_terragrunt_dir()}//modules/app1-env"
}

inputs = {
  input_1 = "value_1"
  input_2 = "value_2"
}

include {
  path = find_in_parent_folders()
}