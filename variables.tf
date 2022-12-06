# --- root/Terraform_projects/terraform_two_tier_architecture/variables.tf

# custom VPC variable
variable "vpcCidrDev" {
  description = "custom vpc CIDR notation"
  type        = string
  default     = "10.100.0.0/16"
}


# public subnet 1 variable 256 ips
variable "publicSubnet1Dev" {
  description = "public subnet 1 CIDR notation"
  type        = string
  default     = "10.100.1.0/24"
}


# public subnet 2 variable
variable "publicSubnet2" {
  description = "public subnet 2 CIDR notation"
  type        = string
  default     = "10.100.2.0/24"
}


# private subnet 1 variable
variable "privateSubnet1Dev" {
  description = "private subnet 1 CIDR notation"
  type        = string
  default     = "10.100.3.0/24"
}


# private subnet 2 variable
variable "privateSubnet2Dev" {
  description = "private subnet 2 CIDR notation"
  type        = string
  default     = "10.100.4.0/24"
}


# AZ 1
variable "az1" {
  description = "availability zone 1 1a"
  type        = string
  default     = "us-east-1a"
}


# AZ 2
variable "az2" {
  description = "availability zone 2 1b"
  type        = string
  default     = "us-east-1b"
}


# ec2 instance ami for Linux
variable "ec2InstanceAmi" {
  description = "ec2 instance ami id"
  type        = string
  default     = "ami-07ffb2f4d65357b42"
}


# ec2 instance type
variable "ec2InstanceTypeDev" {
  description = "ec2 instance type t3 micro for DEV"
  type        = string
  default     = "t3.micro"
}
