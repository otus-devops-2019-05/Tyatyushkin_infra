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

variable zone {
  description = "zone for app"
  default     = "europe-west1-b"
}

variable app_count {
  description = "add count for servers"
  default     = "1"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app"
}
