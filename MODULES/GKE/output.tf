##### output #####
##################

output "cluster" {
  value = google_container_cluster.cluster
}

output "cluster_name" {
  value = google_container_cluster.cluster.name
}

output "main_pool" {
  value = google_container_node_pool.fixed_pool
}

output "preemp_pool" {
  value = google_container_node_pool.preemp_pool
}