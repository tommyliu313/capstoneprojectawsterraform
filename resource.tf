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
# security group rules
resource "aws_security_group_rule" "ssh_to_"{
  from_port         = 22
  protocol          = "tcp"
  security_group_id = ""
  to_port           = 0
  type              = ""
  source_security_group_id = ""
}
# application load balancer
resource "aws_lb" "appgroup" {
  name = "appgroup"
  load_balancer_type = "application"
  security_groups = aws_security_group.ALBSG.id
  subnets = []
}
resource "aws_lb_listener" "appgroup"{
  load_balancer_arn = aws_lb.appgroup.arn
  default_action {}
}
resource "aws_lb_target_group" "appgroup"{
 name = ""
 port = 80
 protocol = "HTTP"
 vpc_id = module.vpc.id
}
# cloud9 environment
resource "aws_cloud9_environment_ec2" "capstone_project" {
  instance_type = var.instance_type
  name          = "example-env"
  provisioner "remote-exec"{
  inline = [
  "git clone https://github.com/baselm/capstoneproject.git",
  "sudo unzip Example.zip -d /var/www/html/",
  "sudo yum -y update",
  "sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2",
  "sudo yum install -y httpd mariadb-server",
  "sudo systemctl start httpd",
  "sudo systemctl enable httpd",
  "sudo systemctl is-enabled httpd"
  ]
}
}

#ec2 launch template
resource "aws_launch_template" "Example-LT"{
  name = ""
}

#ec2

resource "aws_instance" "Bastion" {
  ami = data.aws_ami.ami.id
  instance_type = var.instance_type
provisioner "remote-exec"{
  inline = [
  "git clone https://github.com/baselm/capstoneproject.git",
  "sudo unzip Example.zip -d /var/www/html/",
  "sudo yum -y update",
  "sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2",
  "sudo yum install -y httpd mariadb-server",
  "sudo systemctl start httpd",
  "sudo systemctl enable httpd",
  "sudo systemctl is-enabled httpd"
  ]
}
}

# launch template
resource "aws_launch_template" "Example-LT"{
  name = "Example-LT"
}

resource "aws_autoscaling_group" "appautoscale" {
  name = "appautoscale"
  max_size = 4
  min_size = 2
  desired_capacity = 2
  launch_configuration = ""
  vpc_zone_identifier = module.vpc
  tags ={
    Name = "Web Server"
  }
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