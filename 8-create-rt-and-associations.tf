# Creating the Route Tables
resource "aws_route_table" "dev-public-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "dev-public-rt"
  }
}

# resource "aws_route_table" "dev-private-rt" {
#   vpc_id = aws_vpc.dev-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.dev-igw.id
#   }

#   tags = {
#     Name = "dev-private-rt"
#   }
# }

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public-nat-gateway.id
  }

  tags = {
    Name = "dev-nat-rt"
  }
}

# Associating the Route Tables with the Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev-public.id
  route_table_id = aws_route_table.dev-public-rt.id
}

# resource "aws_route_table_association" "b" {
#   subnet_id      = aws_subnet.dev-private-1.id
#   route_table_id = aws_route_table.dev-private-rt.id
# }

resource "aws_route_table_association" "nat_gateway" {
  subnet_id = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.nat_gateway.id
}

# resource "aws_route_table_association" "c" {
#   subnet_id      = aws_subnet.dev-private-2.id
#   route_table_id = aws_route_table.dev-private-rt.id
# }