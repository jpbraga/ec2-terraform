terraform {
#   backend "s3" {
#     key    = "eval-joao-braga-tfstate-bucket"
#     region = "us-east-1"
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = var.env
      Owner       = "Team-1"
      Service     = "WebService"
      Repository  = "github.com/jpbraga/desafio-stone"
      Type        = "estrategia-infra"
      Terraform   = "true"
    }
  }
}


