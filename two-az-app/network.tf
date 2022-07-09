resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr
}

# --- AZ "a" ---
resource "aws_subnet" "web-a" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.a
  cidr_block = var.web_a.cidr
}

resource "aws_subnet" "app-a" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.a
  cidr_block = var.app_a.cidr
}

resource "aws_subnet" "db-a" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.a
  cidr_block = var.db_a.cidr
}

# --- AZ "b" ---
resource "aws_subnet" "nat-web-b" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.b
  cidr_block = var.web_b.cidr
}

resource "aws_subnet" "app-b" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.b
  cidr_block = var.app_b.cidr
}

resource "aws_subnet" "db-b" {
  vpc_id = aws_vpc.main.id
  availability_zone = var.azs.b
  cidr_block = var.db_b.cidr
}

# --- Internet gateway ---
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# --- Elastic IP ---
resource "aws_eip" "nat-ip-a" {
  vpc = true
}

resource "aws_eip" "nat-ip-b" {
  vpc = true
}

# --- Nat gateway ---
resource "aws_nat_gateway" "app-a" {
  subnet_id = aws_subnet.app-a.id
  allocation_id = aws_eip.nat-ip-a.allocation_id
}

resource "aws_nat_gateway" "app-b" {
  subnet_id = aws_subnet.app-b.id
  allocation_id = aws_eip.nat-ip-b.allocation_id
}

# --- Routing tables ---
resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "web-a-to-gw" {
  route_table_id = aws_route_table.web.id
  subnet_id = aws_subnet.app-a.id
}

resource "aws_route_table_association" "web-b-to-gw" {
  route_table_id = aws_route_table.web.id
  subnet_id = aws_subnet.app-b.id
}

resource "aws_route_table" "app-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.app_a.cidr
    nat_gateway_id = aws_nat_gateway.app-a.id
  }
}

resource "aws_route_table_association" "app-a-to-nat" {
  route_table_id = aws_route_table.app-a.id
  subnet_id = aws_subnet.app-a.id
}

resource "aws_route_table" "app-b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.app_b.cidr
    nat_gateway_id = aws_nat_gateway.app-b.id
  }
}

resource "aws_route_table_association" "app-b-to-nat" {
  route_table_id = aws_route_table.app-b.id
  subnet_id = aws_subnet.app-b.id
}
