terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
variable "digitalocean_token" {
  type = string
  description = "Token for DigitalOcean API"
}

provider "digitalocean" {
    token = var.digitalocean_token
}