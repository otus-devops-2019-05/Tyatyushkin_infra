variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значениепоумолчанию  
  default = "europe-west1"
}

variable public_key_path {
  # Описаниепеременной
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to private key"
}

variable app_zone {
  description = "zone for app"
  default     = "europe-west1-b"
}

