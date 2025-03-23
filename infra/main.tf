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
  tags = ["analytics", "spotify"]
}