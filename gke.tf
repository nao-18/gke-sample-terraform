resource "google_container_cluster" "default" {
  name = "arai-gke"
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    # network policyとセット
    network_policy_config {
      disabled = false
    }
    gcp_filestore_csi_driver_config {
      enabled = false
    }
    gcs_fuse_csi_driver_config {
      enabled = false
    }
    # Knative
    # https://cloud.google.com/kubernetes-engine/enterprise/knative-serving/docs/setup?hl=ja
    cloudrun_config {
      disabled           = true
      load_balancer_type = "=LOAD_BALANCER_TYPE_INTERNAL"
    }
    istio_config {
      disabled = true
      auth     = "AUTH_MUTUAL_TLS"
    }
    dns_cache_config {
      enabled = true
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gke_backup_agent_config {
      enabled = true
    }
    kalm_config {
      enabled = true
    }
    config_connector_config {
      enabled = true
    }
    stateful_ha_config {
      enabled = true
    }
    ray_operator_config {
      enabled = true
    }
    parallelstore_csi_driver_config {
      enabled = true
    }
  }
  network_policy {
    enabled  = "ture"
    provider = "CALICO"
  }

  allow_net_admin = true
  cluster_ipv4_cidr = ""
  cluster_autoscaling {
    enabled = true
    resource_limits {
#       resource_type = "cpu"
      resource_type = "memory"
      minimum = 1
      maximum = 2
    }
    auto_provisioning_defaults {
      min_cpu_platform = "Intel Ice Lake"
      oauth_scopes = []
      service_account = ""
      boot_disk_kms_key = ""
      disk_size = ""
      disk_type = ""
      shielded_instance_config {
        enable_secure_boot = true
        enable_integrity_monitoring = true
      }
      management {
        auto_upgrade = true
        auto_repair = true
      }
      upgrade_settings {
        # SURGEの場合
        strategy = "BLUE_GREEN"
        max_surge = 0
        max_unavailable = 0
        # BLUE_GREENの場合
        strategy = "SURGE"
        blue_green_settings {
          node_pool_soak_duration = ""
          standard_rollout_policy {
            batch_percentage = ""
            batch_node_count = ""
            batch_soak_duration = ""
          }
        }
      }
    }
  }
  authenticator_groups_config {
    security_group = ""
  }
  binary_authorization {
    evaluation_mode = ""
  }
  service_external_ips_config {
    enabled = true
  }
  database_encryption {
    state = ""
  }
}
