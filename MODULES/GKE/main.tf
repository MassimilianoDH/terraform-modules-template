##### common #####
##################

data "google_container_engine_versions" "gke_versions" {
  project  = var.project
  location = var.zone
}

locals {
  kubernetes_version = var.kubernetes_version != "latest" ? var.kubernetes_version : data.google_container_engine_versions.gke_versions.latest_master_version
}

##### cluster #####
###################

resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.zone

  initial_node_count       = var.initial_node_count
  remove_default_node_pool = var.remove_default_node_pool

  network    = var.network_name
  subnetwork = var.subnetwork_name
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }

  logging_service    = "none"
  monitoring_service = "none"

  min_master_version = local.kubernetes_version
}

##### fixed node-pool #####
###########################

resource "google_container_node_pool" "fixed_pool" {
  cluster     = google_container_cluster.cluster.name
  location    = var.zone
  name_prefix = "fixed-node-"

  node_count = var.fixed_node_count

  node_config {
    machine_type = var.fixed_machine_type
    disk_size_gb = var.fixed_node_disk_size_gb
    disk_type    = var.fixed_node_disk_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
    labels = {
      preemptible = "false"
    }
  }

  management {
    auto_repair = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  version = local.kubernetes_version
}

##### preemptible node-pool #####
#################################

resource "google_container_node_pool" "preemp_pool" {
  count = var.create_preemp_node_pool ? 1 : 0

  cluster     = google_container_cluster.cluster.name
  location    = var.zone
  name_prefix = "preemp-node-"

  initial_node_count = 0

  autoscaling {
    min_node_count = 0
    max_node_count = var.max_preemp_nodes
  }

  node_config {
    machine_type = var.preemp_machine_type
    disk_size_gb = var.preemp_node_disk_size_gb
    disk_type    = var.preemp_node_disk_type
    preemptible  = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
    labels = {
      preemptible = "true"
    }
  }

  version = local.kubernetes_version
}