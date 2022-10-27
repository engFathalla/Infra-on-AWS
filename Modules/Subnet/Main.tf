resource "aws_subnet" "MyApp_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.sub_1
  availability_zone = var.avail_zone
  tags = {
    "Name" = "${var.prefix_env}_Subnet_1"
  }
}

resource "aws_internet_gateway" "MyApp_IGW" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "${var.prefix_env}_IGW"
  }
}

resource "aws_route_table" "MyApp_Route_Table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyApp_IGW.id
  }
  tags = {
    "Name" = "${var.prefix_env}_RTP"
  }
}

resource "aws_route_table_association" "Associate_sub_1_RTP" {
  subnet_id      = aws_subnet.MyApp_subnet_1.id
  route_table_id = aws_route_table.MyApp_Route_Table.id
}