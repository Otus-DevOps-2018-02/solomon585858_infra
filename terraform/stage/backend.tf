terraform {
  backend "gcs" {
    bucket = "storage-bucket-marat"
    prefix = "stage"
  }
}
