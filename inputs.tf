variable "project" {}
variable "region" {}
variable "zones" {}
variable "ip_cidr_range" {}
variable "cluster_name" {}
variable "min_master_version" {}
#variable "master_ipv4_cidr_block" {}
variable "autoscaling_min_node_count" {}
variable "autoscaling_max_node_count" {}
variable "machine_type" {}
variable "master_authorized_cidr" {}
variable "additional_zones" {
  type    = "list"
}

#variable "pod_cidr_range" {}