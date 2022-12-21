#Creating public subnet
resource "aws_subnet" "dev-public" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "dev-public"
  }
}

# Creating private subnet
resource "aws_subnet" "dev-private-1" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "dev-private-1"
  }
}

# Creating the 2nd private subnet
# resource "aws_subnet" "dev-private-2" {
#   vpc_id     = aws_vpc.dev-vpc.id
#   cidr_block = "10.0.3.0/24"
#   availability_zone = eu-central-1a

#   tags = {
#     Name = "dev-private-2"
#   }
# }