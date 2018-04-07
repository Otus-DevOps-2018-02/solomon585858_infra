terraform {
  backend "gcs" {
    bucket = "storage-bucket-marat"
    prefix = "terraform/state"
  }
}
