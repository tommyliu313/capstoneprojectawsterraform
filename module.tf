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
}

module "asg"{
  source  = "terraform-aws-modules/autoscaling/aws"
  name = "auto scaling group"

  desired_capacity = 2
  min_size = 2
  max_size = 4
  health_check_type = ""
  tags = {
    name = "WebServer"
  }
}

# ec2 auto scaling group
module "ec2-autoscale-group" {
  source  = "cloudposse/ec2-autoscale-group/aws"
  version = "0.30.1"
}

module "ssm-parameter-store" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.9.1"
  # insert the 12 required variables here
}