# Creating the Security Group for the Public Subnet
resource "aws_security_group" "allow_public_web_traffic" {
  name        = "public_inbound_traffic"
  description = "Allow inbound traffic from the internet"
  vpc_id      = aws_vpc.dev-vpc.id

    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "dev-public-sg"
  }
}

# Creating the Security Group for the Private Subnet
resource "aws_security_group" "allow_private_traffic" {
  name        = "private_inbound_traffic"
  description = "Allow inbound traffic only from the public subnet"
  vpc_id      = aws_vpc.dev-vpc.id

    ingress {
    description      = "ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["10.0.1.0/24"]
  }
    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24"]
  }
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24"]
  }
    ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-private-sg"
  }
}

# Creating the Security Group for the Database
# resource "aws_security_group" "allow_private_db_traffic" {
#   name        = "inbound_db_traffic"
#   description = "Allow private inbound db traffic"
#   vpc_id      = aws_vpc.dev-vpc.id

#     ingress {
#     description      = "MySQL"
#     from_port        = 3306
#     to_port          = 3306
#     protocol         = "tcp"
#     cidr_blocks      = ["10.0.2.0/24"]
#     }

#     tags = {
#     Name = "DEV-ALLOW-PRIVATE-DB"
#   }
# }