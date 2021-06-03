variable "project_id" {
  default = "devops-sandbox-20200519"
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = "default"
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = "default"
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = "cc-sa-sandbox-2020061"
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "static_ips" {
  type        = list(string)
  description = "List of static IPs for VM instances"
  default     = []
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "num_instances" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  default     = "1"
}


variable "region" {
  type        = string
  description = "Region where the instances should be created."
  default     = "asia-southeast1"
}
