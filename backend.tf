terraform {
  backend "s3" {
    bucket         = "tajudeen-altschool-capstone-remote-backend"
    key            = "terraform-aws-eks-workshop.tfstate"
    region         = "eu-west-1"
  }
}
