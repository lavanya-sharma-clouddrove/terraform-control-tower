terraform {
  backend "s3" {
    bucket         = "control-tower-terraform-tfstate"
    key            = "s3/terraform.tfstate"
    region         = "us-east-1"
  }
}
