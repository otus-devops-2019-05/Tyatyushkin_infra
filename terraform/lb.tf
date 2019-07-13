resource "google_compute_instance_group" "reddit-app" {
    name = "reddit-app"
    zone = "${var.app_zone}"
    instances =  [ "${google_compute_instance.app.*.self_link}"]
    named_port {
      name = "http"
      port = "9292"
    }
}



resource "google_compute_health_check" "puma-health-check" {
 name = "puma-service-health-check"

 timeout_sec        = 1
 check_interval_sec = 1

 http_health_check {
   port = "9292"
 }
}

resource "google_compute_backend_service" "puma_backend" {
  name          = "backend-puma"
  protocol      = "HTTP"
  port_name     = "http"
  #region                = "europe-west1"
  health_checks = ["${google_compute_health_check.puma-health-check.self_link}"]
  backend {
    group = "${google_compute_instance_group.reddit-app.self_link}"
  }
}


resource "google_compute_url_map" "urlmap" {
  name        = "urlmap"
  description = "a description"

  default_service = "${google_compute_backend_service.puma_backend.self_link}"
}


resource "google_compute_target_http_proxy" "default" {
  name        = "http-proxy"
  url_map     = "${google_compute_url_map.urlmap.self_link}"
}


resource "google_compute_global_forwarding_rule" "default" {
  name       = "reddia-app"
  #load_balancing_scheme = "EXTERNAL"
  #region                = "europe-west1"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
}
