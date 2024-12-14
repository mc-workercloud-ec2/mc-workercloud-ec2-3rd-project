provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.45.0"
    }
  }

  backend "s3" {
    dynamodb_table = "ec2team-241214-terraform-lock"
    key            = "dev/terraform.tfstate"
    bucket         = "ec2team-241214-terraform-repo-1"
    encrypt        = true
    region         = "ap-northeast-2"
  }
}
