resource "google_storage_bucket" "terraform-bucket-for-state" {
  name                        = "${var.project_id}-terraform-state"
  location                    = "US"
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  labels = {
    "environment" = "${var.project_id}"
  }
}


terraform {
  backend "gcs" {
    # variables can't be used here
    bucket = "landbot-25169-terraform-state"
    prefix = "terraform/state"
  }
}

