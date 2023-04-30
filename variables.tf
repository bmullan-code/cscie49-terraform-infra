variable "project_id" {
  description = "project id"
  default = "barry-mullan"
}

variable "region" {
  description = "region"
  default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-a"
}

variable "terraform_service_account" {
    type = string
    default = "terraform@barry-mullan.iam.gserviceaccount.com"
}

variable "network_subnet_0_cidr" {
    type = string
    default = "10.1.0.0/24"
}

variable "prefix" {
    type = string
    default = "cscie49"
}


variable "terraform_service_account" {
    type = string
}


variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

variable "default_service_account" {
  type = string
  description = "default service account"
}