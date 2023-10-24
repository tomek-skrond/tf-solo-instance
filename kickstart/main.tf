provider "google" {
  credentials = var.credential_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

locals {
  buckets = {
    "socjo" = { bucket_name = "socjo-bucket"},
    # "staging" = { bucket_name = "staging-bucket-bobaklabs"},
    # "prod" = { bucket_name = "prod-bucket-bobaklabs"}
  }
}

module "buckets" {
    source = "./modules/buckets"
    for_each = local.buckets

    bucket_name = each.value.bucket_name
}

# module "workload" {
#     source = "./modules/workload"

#     gcp_project_name = var.project
#     gitlab_project_id = var.project_id
#     gitlab_namespace_path = "bobak-labs/zbi-proj"
# }
# output "bucket_name" {
#   value = local.bucket_name
# }