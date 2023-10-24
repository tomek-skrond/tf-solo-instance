resource "google_storage_bucket" "env_buckets" {
  name = var.bucket_name
  force_destroy = true
  location      = "EU"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }

}