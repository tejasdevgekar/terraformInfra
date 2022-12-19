# SECURITY BLOCK

# create security groups for vpc (web_sg), webserver, and database

# custom vpc security group 
resource "aws_security_group" "web_sg" {
   name        = "web_sg"
   description = "allow inbound HTTP traffic"
   vpc_id      = aws_vpc.custom_vpc.id

   # HTTP from vpc
   ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }


  # outbound rules
  # internet access to anywhere
  egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     name = "web_sg"
  }
}


# web tier security group
resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "allow inbound traffic from ALB"
  vpc_id      = aws_vpc.custom_vpc.id

  # allow inbound traffic for HTTP
  ingress {
     from_port       = 80
     to_port         = 80
     protocol        = "tcp"
     security_groups = [aws_security_group.web_sg.id]
  }

  ingress {
     from_port       = 22
     to_port         = 22
     protocol        = "tcp"
     security_groups = $$$$$$$$$$$$$$$$$$
  }

  egress {
     from_port = "0"
     to_port   = "0"
     protocol  = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     name = "webserver_sg"
  }
}
