module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  # insert the 23 required variables here
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0"
  # insert the 38 required variables here
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.9.0"
  # insert the 4 required variables here
  name = "my-alb"
  vpc_id = ""
  subnet =
}