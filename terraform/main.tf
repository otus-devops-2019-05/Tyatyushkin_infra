terraform {
  # Версия terraform  
  required_version = "0.11.7"
}

provider "google" {
  # Версияпровайдера  
  version = "2.0.0"

  # ID проекта  
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_project_metadata_item" "default" {
  key = "ssh-keys"
  value = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
}


resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.app_zone}"
  tags         = ["reddit-app"]

  # определениезагрузочногодиска 
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # определениесетевогоинтерфейса
  network_interface {
    # сеть, ккоторойприсоединитьданныйинтерфейс    
    network = "default"

    # использовать ephemeral IP длядоступаизИнтернет    
    access_config {}
  }

  metadata {
    ssh-keys = "masterplan:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "masterplan"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Названиесети, вкоторойдействуетправило  
  network = "default"

  # Какойдоступразрешить  
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Какимадресамразрешаемдоступ  
  source_ranges = ["0.0.0.0/0"]

  # Правилоприменимодляинстансовсперечисленнымитэгами  
  target_tags = ["reddit-app"]
}
