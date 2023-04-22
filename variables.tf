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