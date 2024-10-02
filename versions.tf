terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.5.0"
    }
  }

  required_version = ">= 0.14"
}