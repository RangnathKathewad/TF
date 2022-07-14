data "google_compute_image" "adh_image" {
  family  = "ubuntu-pro-2004-lts"
  project = "ubuntu-os-pro-cloud"
}

locals{
template_date =formatdate("YYYYDDhhmm", timestamp())
}

resource "google_compute_instance_template" "default" {
  name        = "${var.instance_template_name}-${local.template_date}"
  description = "This template is used to create app server instances."
  tags = ["allow-health-check"]

  labels = {
	environment=var.environment
  }

  instance_description = "description assigned to instances"
  machine_type         = "e2-standard-8"
  
  
  // Create a new boot disk from an image
  disk {
    source_image      = "${data.google_compute_image.adh_image.self_link}"
    auto_delete       = false
    boot              = true
    disk_size_gb	  =	200
	}
	

metadata =  {
    metadata_startup_script = file(var.startup_script)
}
    

network_interface {
    network = "default"
  }

  
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}
