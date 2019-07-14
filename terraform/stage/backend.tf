#resource "google_storage_bucket" "masterplan_tfstate" {
#  name     = "masterplan_tfstart"
#  location = "EU"
#}

terraform {
  backend "gcs" {
    bucket  = "tyatyushkin-tfstat"
    prefix  = "stage"
  }
}

