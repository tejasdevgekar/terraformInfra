# VPC BLOCK

# creating VPC
resource "aws_vpc" "custom_vpc" {
   cidr_block       = "${var.vpc_cidr}"

   tags = {
      Name = "custom_vpc"
   }
}


# public subnet 1
resource "aws_subnet" "public_subnet1" {   
   vpc_id            = "${aws_vpc.custom_vpc.id}"
   cidr_block        = "${var.public_subnet1}"
   availability_zone = "${var.az1}"

   tags = {
      Name = "public_subnet1"
   }
}


# public subnet 2
resource "aws_subnet" "public_subnet2" {  
  vpc_id            = "${aws_vpc.custom_vpc.id}"
  cidr_block        = "${var.public_subnet2}"
  availability_zone = "${var.az2}"

  tags = {
     Name = "public_subnet2"
  }
}


# private subnet 1
resource "aws_subnet" "private_subnet1" {   
   vpc_id            = "${aws_vpc.custom_vpc.id}"
   cidr_block        = "${var.private_subnet1}"
   availability_zone = "${var.az1}"

   tags = {
      Name = "private_subnet1"
   }
}


# private subnet 2
resource "aws_subnet" "private_subnet2" {   
   vpc_id            = "${aws_vpc.custom_vpc.id}"
   cidr_block        = "${var.private_subnet2}"
   availability_zone = "${var.az2}"

   tags = {
      Name = "private_subnet2"
   }
}


# creating internet gateway 
resource "aws_internet_gateway" "igw" {
   vpc_id = "${aws_vpc.custom_vpc.id}"

   tags = {
      Name = "igw"
   }
}


# creating public route table
resource "aws_route_table" "public" {
   vpc_id = "${aws_vpc.custom_vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
      Name = "rt"
  }
}


# creating private route table1
resource "aws_route_table" "private1" {
   vpc_id = "${aws_vpc.custom_vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat1.id}"
  }

  tags = {
      Name = "rt private1"
  }
}


# creating private route table2
resource "aws_route_table" "private2" {
   vpc_id = "${aws_vpc.custom_vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat2.id}"
  }

  tags = {
      Name = "rt private2"
  }
}


# EIP for NAT gateway
resource "aws_eip" "nat1" {
    vpc = true
}


# EIP for NAT gateway 2
resource "aws_eip" "nat2" {
    vpc = true
}



# NAT gateway 1
resource "aws_nat_gateway" "nat1" {
  allocation_id = "${aws_eip.nat1.id}"
  subnet_id     = "${aws_subnet.public_subnet1.id}"

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


# NAT gateway
resource "aws_nat_gateway" "nat2" {
  allocation_id = "${aws_eip.nat2.id}"
  subnet_id     = "${aws_subnet.public_subnet2.id}"

  tags = {
    Name = "gw NAT2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


# associate route table to the public subnet 1
resource "aws_route_table_association" "public_rt1" {
   subnet_id      = "${aws_subnet.public_subnet1.id}"
   route_table_id = "${aws_route_table.public.id}"
}


# associate route table to the public subnet 2
resource "aws_route_table_association" "public_rt2" {
   subnet_id      = "${aws_subnet.public_subnet2.id}"
   route_table_id = "${aws_route_table.public.id}"
}


# associate route table to the private subnet 1
resource "aws_route_table_association" "private_rt1" {
   subnet_id      = "${aws_subnet.private_subnet1.id}"
   route_table_id = "${aws_route_table.private1.id}"
}


# associate route table to the private subnet 2
resource "aws_route_table_association" "private_rt2" {
   subnet_id      = "${aws_subnet.private_subnet2.id}"
   route_table_id = "${aws_route_table.private2.id}"
}