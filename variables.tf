variable "public_subnets"{
 type = list(string)
 default =  [10.0.0.0/24,10.0.1.0/24]
}

variable "private_subnets"{
 type = list(string)
 default =  [10.0.2.0/23,10.0.4.0/23]
}

variable "instance_type"{
 default = "t2.micro"
}

variable "region" {
 type = string
 default = "us-east1"
}

variable "access_key"{
 default = ""
}

variable "secret_key"{
 default = ""
}