//Reserving an external IP address
resource "google_compute_global_address" "default" {
  provider = google-beta
  project = var.project_id	
  name = "lb-vip-${var.environment}"
 }

//creating ssl certs
resource "google_compute_managed_ssl_certificate" "default" {
  name = "www-ssl-cert-adh-${var.domain_name}"
  managed {
    domains = var.domain
  }
}
//create health check for backend service
resource "google_compute_health_check" "http_health_check" {
  name = "http-check-adh-${var.environment}"
  http_health_check {
    port = 80
  }
}
//create health check for websocket backend service
resource "google_compute_health_check" "http_health_websocket_check" {
  name = "http-websocket-check-adh-${var.environment}"
  http_health_check {
    port = 8080
  }
}
//Setting up Load balancer
//cretae backend service
resource "google_compute_backend_service" "default" {
  name                     = "web-backend-service-adh-${var.environment}"
  protocol                 = "HTTP"
  port_name                = "http"
  load_balancing_scheme    = "EXTERNAL"
  timeout_sec              = 300
  health_checks            = [google_compute_health_check.http_health_check.id]
  backend {
    group = "${google_compute_region_instance_group_manager.instance_group.instance_group}"
  }
}
//cretae websocket backend service
resource "google_compute_backend_service" "websocket" {
  name                     = "web-socket-backend-service-adh-${var.environment}"
  protocol                 = "HTTP"
  port_name                = "websocket"
  load_balancing_scheme    = "EXTERNAL"
  timeout_sec              = 1800
  health_checks            = [google_compute_health_check.http_health_websocket_check.id]
  backend {
    group = "${google_compute_region_instance_group_manager.instance_group.instance_group}"
	}
}

//URL MAP
resource "google_compute_url_map" "urlmap" {
  name        = "web-https-adh-lb-${var.environment}"
  default_service = google_compute_backend_service.default.self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "web-https-adh-path-matcher-${var.environment}"
  }
  
path_matcher {
      name = "web-https-adh-path-matcher-${var.environment}"  
      default_service = google_compute_backend_service.default.self_link
    
    path_rule {
      paths   = ["/ws/*"]
      service = google_compute_backend_service.websocket.self_link
    }
  }	
 }
  //Setting up an HTTPS frontend
  resource "google_compute_target_https_proxy" "default" {
  name             = "https-proxy-adh-lb-${var.environment}"
  url_map          = google_compute_url_map.urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}
  
  //create rule to route incoming requests to the proxy
  resource "google_compute_global_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "https-content-rule-adh-${var.environment}"
  ip_protocol           = "HTTPS"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.self_link
  ip_address            = google_compute_global_address.default.id 
}
