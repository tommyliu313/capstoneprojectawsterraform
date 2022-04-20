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

resource "aws_security_group" "ALBSG"{
  name = "application load balancer"
}

# application load balancer
resource "aws_alb_target_group" "appgroup"{

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

resource "aws_instance" "Bastion" {
  ami = data.aws_ssm_parameter.ami.value
}

# launch template
resource "aws_launch_template" "Example-LT"{
  name = "Example-LT"
}
# database subnet group
resource "aws_db_subnet_group" "exampledbsubnet"{
  description = "Example db subnet"
  vpc_id = module.vpc.vpc_id
  subnet_ids  = []
}
# systems manager parameter store
resource "aws_ssm_parameter" "endpoint"{
  name = "/example/endpoint"
  description = ""
  type = "SecureString"
  value = module.db.db_instance_endpoint
}

resource "aws_ssm_parameter" "username"{
  name = "/example/username"
  type = ""
  value = "admin"
}

resource "aws_ssm_parameter" "password"{
  name = "/example/password"
  type = ""
  value = "lab-password"
}

resource "aws_ssm_parameter" "database"{
  name = "/example/database"
  type = ""
  value = "exampledb"
}