# my changes
resource "google_storage_bucket" "auto-expire" {
  name          = "cscie49-no-public-access-bucket"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"

}
