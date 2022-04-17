variable "public_subnet"{
 type = list(string)
 default =  [10.0.0.0/24,10.0.1.0/24]
}

variable "private_subnet"{
 type = list(string)
 default =  [10.0.2.0/23,10.0.4.0/23]
}