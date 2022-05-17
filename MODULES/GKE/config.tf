##### config #####
##################

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.21.0"
    }
  }
}

provider "google" {
  # Configuration options
}