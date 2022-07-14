provider "google" {
  credentials = file(var.tf_service_account_key_file)
  project     = var.project_id
  region      = var.region
}
