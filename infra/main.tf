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

resource "digitalocean_droplet" "spotify_analytics" {
  image   = "ubuntu-20-04-x64"
  name    = "spotify-analytics"
  region  = "nyc2"
  size    = "s-1vcpu-1gb"

  tags = ["analytics", "spotify"]
}