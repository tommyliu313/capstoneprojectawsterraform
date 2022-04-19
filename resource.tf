# security group
resource "aws_security_group" "Example-DBSG"{
description = "Enable access to MySQL"
}

resource "aws_security_group" "Bastion-SG"{

}

resource "aws_security_group" "Inventory-App"{
description = "Enable access to App"
}

resource "aws_security_group_rule" "MySQL_Access_Inbound"{
  type = "ingress"
  protocol = "MYSQL/Aurora"
  security_group_id = aws_security_group.Example-DBSG
  from_port = 0
  to_port = 3306
  cidr_blocks = [aws_vpc.example.cidr_block]
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