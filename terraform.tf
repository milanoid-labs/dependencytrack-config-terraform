terraform {

  required_version = "~> 1.12"

  backend "s3" {
    bucket       = "milanoid-labs-terraform-tofu-state"
    key          = "dependencytrack-config-terraform/terraform.tfstate"
    use_lockfile = true
    region       = "eu-central-1"
    # Locally: direnv (.envrc) sets AWS_PROFILE=milanoid.
    encrypt = true # to make it explicit, S3 default encryption is enabled in AWS
  }

  required_providers {
    dependencytrack = {
      # Tested upstream against DependencyTrack 5.2.x (what homelab-cluster runs);
      # SolarFactories/dependencytrack is only tested on 4.x.
      source  = "ottramst/dependencytrack"
      version = "~> 0.7.0"
    }
  }
}

variable "dependencytrack_url" {
  type        = string
  description = "DependencyTrack base URL. LAN-only, plain HTTP (Traefik has only its default cert on 443); the ingress routes /api to the api-server. Reachable from homelab-runners and local machines."
  default     = "http://dependencytrack.milanoid.net"
}

variable "dependencytrack_api_key" {
  type        = string
  description = "API key of the hand-made 'tofu' team (all permissions, not managed here). Supplied via TF_VAR_dependencytrack_api_key (CI: repo secret TF_VAR_DEPENDENCYTRACK_API_KEY)."
  sensitive   = true
}

provider "dependencytrack" {
  endpoint = var.dependencytrack_url
  api_key  = var.dependencytrack_api_key
}
