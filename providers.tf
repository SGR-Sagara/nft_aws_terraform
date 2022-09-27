terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.65.0"  ## was 3.64.2
    }
  }
}

terraform {
  backend "s3" {
    bucket = "euroleague-clancy-20220515"
    key    = "euroleague.tfstate"
    region = "ca-central-1"
  }
}

provider "aws" {
  region = "ca-central-1"
}