# security group
resource "aws_security_group" "Example-DBSG"{
  name = "example database security group"
  vpc_id = module.vpc.vpc_id
  description = "Enable access to MySQL"
  ingress {

    from_port = 0
    protocol  = "MYSQL/Aurora"
    to_port   = 3306
  }
  egress{

    from_port = 0
    protocol  = "MySQL/Aurora"
    to_port   =
  }
}

resource "aws_security_group" "Bastion-SG"{

}

resource "aws_security_group" "Inventory-App"{
description = "Enable access to App"
}

# cloud9 environment
resource "aws_cloud9_environment_ec2" "capstone_project" {
  instance_type = "t2.micro"
  name          = "example-env"
}

#ec2 launch template
resource "aws_launch_template" "Example-LT"{

}

#ec2