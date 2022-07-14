resource "google_compute_region_instance_group_manager" "instance_group" {
  name      = var.instance_group_name
  region      = var.region
  distribution_policy_zones  = var.zones

  target_size = var.size  
 
  version {
   name = "${var.instance_template_name}-${local.template_date}"
   instance_template = "${google_compute_instance_template.default.self_link}"
  }
  base_instance_name="adh-test"
  
  named_port {
    name = "http"
    port = "80"
  }
  
  named_port {
    name = "websocket"
    port = "8080"	
  }

  lifecycle {
    create_before_destroy = true
  }
  
  depends_on=[google_compute_instance_template.default]
}
