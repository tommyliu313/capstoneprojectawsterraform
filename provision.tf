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