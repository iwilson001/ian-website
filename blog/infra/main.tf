terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  # API token will be read from CLOUDFLARE_API_TOKEN environment variable
}

variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Domain name"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the Cloudflare Pages project"
  type        = string
}

variable "site_name" {
  description = "Name of the Cloudflare Pages project"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare Zone ID for the domain"
  type        = string
  sensitive   = true
}

resource "cloudflare_pages_project" "site" {
  account_id        = var.account_id
  name              = var.site_name
  production_branch = "main"
}

resource "cloudflare_pages_domain" "ian-website-blog-domain" {
  account_id   = var.account_id
  name         = "${var.subdomain}.${var.domain}"
  project_name = cloudflare_pages_project.site.name
}

resource "cloudflare_dns_record" "cname" {
  name    = var.subdomain
  type    = "CNAME"
  content = cloudflare_pages_project.site.subdomain
  depends_on = [ cloudflare_pages_project.site ]
  ttl     = 1
  zone_id = var.zone_id
  proxied = true
}
