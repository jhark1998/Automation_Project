#
# Create VPC
resource "aws_vpc" "rishi1998" {
 cidr_block = "10.0.0.0/16"

 tags = {
   Name = "rishi1998"
 }
}
#
# Create public subnet in availability zone us-east-1a
resource "aws_subnet" "rishi1998-public-subnet-1a" {
  vpc_id     = "${aws_vpc.rishi1998.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "rishi1998-public-subnet-1a"
  }
}
#
# Create public subnet in availability zone us-east-1b
resource "aws_subnet" "rishi1998-public-subnet-1b" {
  vpc_id     = "${aws_vpc.rishi1998.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "rishi1998-public-subnet-1b"
  }
}
#
# Create private subnet in availability zone ap-south-1a
resource "aws_subnet" "rishi1998-private-subnet-1a" {
  vpc_id     = "${aws_vpc.rishi1998.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "rishi1998-private-subnet-1a"
  }
}
#
# Create private subnet in availability zone ap-south-1b
resource "aws_subnet" "rishi1998-private-subnet-1b" {
  vpc_id     = "${aws_vpc.rishi1998.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "rishi1998-private-subnet-1b"
  }
}
#
# Create internet gateway
resource "aws_internet_gateway" "rishi1998_igw" {
  vpc_id = "${aws_vpc.rishi1998.id}"

  tags = {
    Name = "rishi1998-igw"
  }
}
#
# Create route table for public subnet
resource "aws_route_table" "rishi1998-public-route" {
  vpc_id = "${aws_vpc.rishi1998.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.rishi1998_igw.id}"
  }

  tags = {
    Name = "rishi1998-public-route"
  }
}
#
# Associate route tabe to public subnet 1a
resource "aws_route_table_association" "rishi1998-1a" {
  subnet_id      = "${aws_subnet.rishi1998-public-subnet-1a.id}"
  route_table_id = "${aws_route_table.rishi1998-public-route.id}"
}

#
# Create Elastic IP
resource "aws_eip" "rishi1998-eip" {
  vpc      = true
  tags = {
    Name = "rishi1998-eip"
  }
}
#
# Create NAT Gateway
resource "aws_nat_gateway" "rishi1998-ngw" {
  allocation_id = "${aws_eip.rishi1998-eip.id}"
  subnet_id     = "${aws_subnet.rishi1998-public-subnet-1a.id}"

  tags = {
    Name = "rishi1998-Nat Gateway"
  }
}
#
# Create route table for private subnet
resource "aws_route_table" "rishi1998-private-route" {
  vpc_id = "${aws_vpc.rishi1998.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.rishi1998-ngw.id}"
  }

}

# Associate route table to private subnet
 resource "aws_route_table_association" "rishi1998-private-1a" {
  subnet_id      = aws_subnet.rishi1998-private-subnet-1a.id
  route_table_id = aws_route_table.rishi1998-private-route.id
}