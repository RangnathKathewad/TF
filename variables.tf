
variable "project_id" {
type = string
}


variable "environment" {
type = string
}

variable "instance_template_name" {
type = string
}

variable "size" {
type = number
}

variable "service_account" {
type = string
}

variable "startup_script" {
type = string
}

variable "region" {
type = string
}

variable "zones" {
type = list
default = []
}

variable "instance_group_name" {
type = string
}

variable "base_instance_name" {
type = string
}

variable "domain" {
type = list
default = []
}

variable "domain_name" {
type = string
}

variable "branch" {
type = string
}

variable "tf_service_account_key_file" {
type = string
}

