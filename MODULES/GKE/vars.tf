##### common #####
##################

variable "project" {
  type = string
}

variable "zone" {
  type = string
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the master. If set to 'latest' it will pull latest available version in the selected region."
  default     = "latest"
}

##### cluster #####
###################

variable "cluster_name" {
  type        = string
  description = "Name of the cluster to be created."
}

variable "initial_node_count" {
  type        = number
  description = "Initial node count of the node-pool to be created. (Must be higher than 0)"
  default     = 1
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Wether or not to remove the original node-pool. (Must be true)"
  default     = true
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network this cluster will be assigned to."
}

variable "subnetwork_name" {
  type        = string
  description = "Name of the VPC sub-network this cluster will be assigned to."
}

##### fixed node-pool #####
###########################

variable "fixed_node_count" {
  type        = string
  description = "Number of fixed nodes to be created. (Must be higher than 0)"
  default     = 1
}

variable "fixed_machine_type" {
  type        = string
  description = "Machine type for stable node-pool."
  default     = "e2-standard-2"
}

variable "fixed_node_disk_size_gb" {
  type        = number
  description = "Fixed node disk size in gigabytes."
  default     = 20
}

variable "fixed_node_disk_type" {
  type        = string
  description = "Fixed node disk type."
  default     = "pd-standard"
}

##### preemptible node-pool #####
#################################

variable "create_preemp_node_pool" {
  type        = bool
  description = "Wether to create a preemptible node-pool."
  default     = false
}

variable "max_preemp_nodes" {
  type        = number
  description = "Maximum ammount of preemptible nodes in pool."
  default     = 10
}

variable "preemp_machine_type" {
  description = "Machine type for preemptible node-pool."
  default     = "n2d-standard-2"
  type        = string
}

variable "preemp_node_disk_size_gb" {
  type        = number
  description = "Preemptible node disk size in gigabytes."
  default     = 10
}

variable "preemp_node_disk_type" {
  type        = string
  description = "Preemptible node disk type."
  default     = "pd-standard"
}
