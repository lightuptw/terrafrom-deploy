# # [START gke_quickstart_autopilot_cluster]
# resource "google_compute_network" "lightup_ms" {
#   name = "microservices-network"
#   project =  "lightup-tw"

#   auto_create_subnetworks  = false
#   enable_ula_internal_ipv6 = true
# }

resource "google_compute_subnetwork" "lightup_ms" {
  name = "microservices-subnetwork"

  ip_cidr_range = "10.40.0.0/20"
  region        = "asia-east1"
  project =  "lightup-tw"

  stack_type       = "IPV4_ONLY"
#   ipv6_access_type = "INTERNAL" # Change to "EXTERNAL" if creating an external loadbalancer

  network = "default"
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.40.32.0/20"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.40.64.0/20"
  }
}

resource "google_container_cluster" "lightup_ms" {
  name = "microservices"

  location                 = "asia-east1"
  # enable_l4_ilb_subsetting = true

  network    = "default"
  subnetwork = google_compute_subnetwork.lightup_ms.id
  # network    = "default"
  # subnetwork = "default"
  project =  "lightup-tw"
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }

  }
  
  # cluster_autoscaling {
  #   enabled = false
  #   resource_limits {
  #     resource_type = "cpu"
  #     minimum       = 8
  #     maximum       = 18
  #   }

  #   resource_limits {
  #     resource_type = "memory"
  #     minimum       = 8
  #     maximum       = 18
  #   }

  # }

  ip_allocation_policy {
    stack_type                    = "IPV4"
    services_secondary_range_name = google_compute_subnetwork.lightup_ms.secondary_ip_range[0].range_name
    cluster_secondary_range_name  = google_compute_subnetwork.lightup_ms.secondary_ip_range[1].range_name
    # services_ipv4_cidr_block = "10.140.8.0/21"
    # cluster_ipv4_cidr_block  = "10.140.16.0/21"
  }

  # Set `deletion_protection` to `true` will ensure that one cannot
  # accidentally delete this instance by use of Terraform.
  deletion_protection = true
}

resource "google_container_cluster" "lightup_development" {
  name = "development"

  location                 = "asia-east1"
  # enable_l4_ilb_subsetting = true

  network    = "default"
  subnetwork = google_compute_subnetwork.lightup_ms.id
  # network    = "default"
  # subnetwork = "default"
  project =  "lightup-tw"
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }

  }

  ip_allocation_policy {
    stack_type                    = "IPV4"
    services_secondary_range_name = google_compute_subnetwork.lightup_ms.secondary_ip_range[0].range_name
    cluster_secondary_range_name  = google_compute_subnetwork.lightup_ms.secondary_ip_range[1].range_name
    # services_ipv4_cidr_block = "10.140.8.0/21"
    # cluster_ipv4_cidr_block  = "10.140.16.0/21"
  }

  # Set `deletion_protection` to `true` will ensure that one cannot
  # accidentally delete this instance by use of Terraform.
  deletion_protection = true
}

resource "google_container_node_pool" "production_base_nodes" {
  name       = "production-base-nodes"
  location   = "asia-east1"
  project = "lightup-tw"
  cluster    = google_container_cluster.lightup_ms.name

  initial_node_count = 1

  node_locations = [
    "asia-east1-a",
    "asia-east1-b",
    "asia-east1-c",
  ]

  # autoscaling {
  #   min_node_count = 0
  #   max_node_count = 6
  #   location_policy = "BALANCED"
  # }

  node_config {
    spot  = true
    machine_type = "e2-medium"

    disk_size_gb = "20"
    tags = ["production"]

    resource_labels = {
      production = true
      environment = "production"
    }

    labels = {
      environment = "production"
    }


    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  network_config {
    enable_private_nodes = true
  }
}

resource "google_container_node_pool" "production_nodes" {
  name       = "production-nodes"
  location   = "asia-east1"
  project = "lightup-tw"
  cluster    = google_container_cluster.lightup_ms.name

  # initial_node_count = 1

  node_locations = [
    "asia-east1-a",
    "asia-east1-b",
    "asia-east1-c",
  ]
  

  autoscaling {
    min_node_count = 0
    max_node_count = 6
    location_policy = "BALANCED"
  }

  node_config {
    spot  = true
    machine_type = "e2-medium"

    disk_size_gb = "20"

    tags = ["production"]

    resource_labels = {
      production = true
      environment = "production"
    }

    labels = {
      environment = "production"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  network_config {
    enable_private_nodes = true
  }
}

resource "google_container_node_pool" "development_nodes" {
  name       = "development-nodes"
  location   = "asia-east1"
  project = "lightup-tw"
  cluster    = google_container_cluster.lightup_development.name

  node_locations = [
    "asia-east1-b",
    "asia-east1-c",
  ]
  node_count = 1
  # autoscaling {
  #   min_node_count = 1
  #   max_node_count = 6
  #   location_policy = "BALANCED"
  # }

  node_config {
    spot  = true
    machine_type = "e2-medium"

    labels = {
      environment = "development"
    }

    tags = ["development"]

    disk_size_gb = "10"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  network_config {
    enable_private_nodes = true
  }
}

# resource "google_container_node_pool" "deploy_nodes" {
#   name       = "deploy-nodes"
#   location   = "asia-east1"
#   project = "lightup-tw"
#   cluster    = google_container_cluster.lightup_development.name

#   node_locations = [
#     "asia-east1-a",
#   ]
#   node_count = 1

#   node_config {
#     machine_type = "e2-medium"

#     labels = {
#       deploy = true
#     }

#     disk_size_gb = "10"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     # service_account = google_service_account.default.email
#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }

#   network_config {
#     enable_private_nodes = true
#   }
# }

resource "google_container_node_pool" "postgres_nodes" {
  name       = "postgres-nodes"
  location   = "asia-east1"
  project = "lightup-tw"
  cluster    = google_container_cluster.lightup_ms.name

  node_count = 1

  node_locations = [
    "asia-east1-a",
  ]

  node_config {
    machine_type = "e2-medium"

    labels = {
      postgres = true
    }

    taint {
      key = "database"
      value = "true"
      effect = "NO_SCHEDULE"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  network_config {
    enable_private_nodes = true
  }
}
