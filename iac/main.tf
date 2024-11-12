provider "google" {
  project = "<PROJECT_ID>"  # Replace with your actual project ID
  region  = "us-central1"           # Replace with your desired region
}

resource "google_container_cluster" "primary" {
  name     = "<CLUSTER_NAME>" # Replace with your cluster name
  location = "us-central1"
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}

output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "kubernetes_cluster_ca_certificate" {
  value = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  sensitive = true
}

output "kubernetes_cluster_client_certificate" {
  value = base64decode(google_container_cluster.primary.master_auth[0].client_certificate)
}

output "kubernetes_cluster_client_key" {
  value     = base64decode(google_container_cluster.primary.master_auth[0].client_key)
  sensitive = true
}
