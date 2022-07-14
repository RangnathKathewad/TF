resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = "fw-allow-health-check-adh-${var.environment}"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080"]
  }
  direction = "INGRESS"
  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["allow-health-check"]
}
