terraform {

  required_version = ">= 1.0" 
  
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 2.0.0"
    }
  }
}

provider "minio" {
  minio_server       = "minio-ui.test"
  minio_user   = "FLVqceSq1cv7YgOS"
  minio_password   = "tGb5kZGn7B3VcKfyGnaLiqbtPjlwFXPm"
}

variable "minio_bucket_name" {
  description = "Bucket name"
  type = string
}

resource "minio_s3_bucket" "bucket" {
  bucket = var.minio_bucket_name
  acl    = "public"
}

output "minio_id" {
  value = minio_s3_bucket.bucket.id
}

output "minio_url" {
  value = minio_s3_bucket.bucket.bucket_domain_name
}