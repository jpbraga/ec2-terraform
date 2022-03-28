locals {
    key_pair_name = "${var.name}-${var.env}"
    instance_name = "${var.name}-${var.env}"
}

variable "name" {
  type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_id" {
    type = string
}

variable "ssh_ip_cidr_blocks" {
    type = list(string)
}

variable "env" {
  type = string
}

variable "key_name" {
    type = string
}

variable "enable_http" {
    type = bool
}

