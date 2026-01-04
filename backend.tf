terraform {
  backend "s3" {
    bucket       = "terraform-aws-backend-bucket-anirudh"
    key          = "dev/day16/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
