resource "google_service_account" "bigquery_scheduled_queries" {
  account_id   = "bigquery-scheduled-queries"
  display_name = "BigQuery Scheduled Queries Service Account"
  description  = "Used to run BigQuery Data Transfer jobs."
  project = var.target_project
}
