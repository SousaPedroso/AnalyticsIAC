terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
variable "analytics_iac_droplet" {
  type = string
  description = "Token for DigitalOcean API"
}

variable "private_key" {
  type = string
  description = "Path to the private key"
}


provider "digitalocean" {
    token = var.analytics_iac_droplet
}

data "digitalocean_ssh_key" "digital_oceans" {
  name = "digital_oceans"
}

resource "digitalocean_droplet" "spotify_analytics" {
  image   = "ubuntu-20-04-x64"
  name    = "spotify-analytics"
  region  = "nyc2"
  size    = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.digital_oceans.id]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.private_key)
    timeout = "2m"
  }

  tags = ["analytics", "spotify"]
}