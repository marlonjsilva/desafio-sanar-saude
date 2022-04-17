// Create Prod VPC: begin
resource "aws_vpc" "prod" {
  cidr_block           = "10.255.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "${var.vpc_name}.igw"
  }
}
// Create Prod VPC: end

// Public Subnet: begin

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.255.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "sanar.public.subnet"
  }
}

resource "aws_nat_gateway" "prod" {
  allocation_id = aws_eip.prod_nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "sanar.prod.nat"
  }
  depends_on = [
    aws_eip.prod_nat_eip,
    aws_internet_gateway.prod
  ]
}
resource "aws_eip" "prod_nat_eip" {
  vpc        = true
  depends_on = [aws_vpc.prod]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "sanar.public.route.table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

}
resource "aws_security_group" "devs-remote-login-in" {
  name        = "${var.vpc_name}-bastion-remote-login-in"
  description = "Allow inbound traffic for devs remote login"
  vpc_id      = aws_vpc.prod.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
// Public Subnet: end

