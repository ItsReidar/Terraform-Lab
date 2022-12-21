# creating a elastic ip and nat gateway and assigning the elastic ip to the nat gateway
resource "aws_eip" "dev-eip" {
  vpc      = true
}

resource "aws_nat_gateway" "public-nat-gateway" {
  allocation_id = aws_eip.dev-eip.id
  subnet_id     = aws_subnet.dev-public.id

  tags = {
    Name = "Private-NAT-Gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.dev-igw]
}