module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  #availability zones
  azs = ["${var.region}a","${var.region}b"]
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

# database
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0"
  engine = "mysql"
  db_name = "example"
  username = "admin"
  port = "3306"
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
  vpc_id = module.vpc.vpc_id
  subnet = [var.public_subnets[0],var.public_subnets[1]]
  security_groups = aws_security_group.ALBSG
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  # insert the 34 required variables here
}