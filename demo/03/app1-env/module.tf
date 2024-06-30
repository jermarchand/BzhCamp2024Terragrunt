module "my_bucket" {
  source = "../../03/module_bucket"

  minio_bucket_name = "bucket-for-${var.env_type}"
}
