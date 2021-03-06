resource "aws_internet_gateway" "cncf" {
  vpc_id = "${ aws_vpc.cncf.id }"

  tags {
    KubernetesCluster = "${ var.name }"
    Name = "${ var.name }"
  }
}

resource "aws_subnet" "cncf" {
  availability_zone = "${ var.aws_availability_zone }"
  cidr_block = "${ var.subnet_cidr }"
  vpc_id = "${ aws_vpc.cncf.id }"

  tags {
    KubernetesCluster = "${ var.name }"
    Name = "${ var.name }-public"
  }
}

resource "aws_route_table" "cncf" {
  vpc_id = "${ aws_vpc.cncf.id }"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.cncf.id }"
  }

  tags {
    KubernetesCluster = "${ var.name }"
    Name = "${ var.name }-public"
  }
}

resource "aws_route_table_association" "cncf" {
  route_table_id = "${ aws_route_table.cncf.id }"
  subnet_id = "${ aws_subnet.cncf.id }"

}