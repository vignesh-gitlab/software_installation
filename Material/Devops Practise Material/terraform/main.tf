terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

#VPC Creation
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"  #65536 ip's
  instance_tenancy = "default"

  tags = {
    Name = "MY-VPC"
  }
}

#Public Subnet
resource "aws_subnet" "subpub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"    #256 ip's
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "My-Sub-Pub"
  }
}

#Private Subnet
resource "aws_subnet" "subpvt" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"    #256 ip's
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "My-Sub-Pvt"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "TIGW"
  }
}

# Public Routing Table
resource "aws_route_table" "rtpub" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "RT-Pub"
  }
}

# Private Routing Table
resource "aws_route_table" "rtpvt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tnat.id
  }

  tags = {
    Name = "RT-Pvt"
  }
}

#Public Subnet Association
resource "aws_route_table_association" "rtpubasso" {
  subnet_id      = aws_subnet.subpub.id
  route_table_id = aws_route_table.rtpub.id
}

#Private Subnet Association
resource "aws_route_table_association" "rtpvtasso" {
  subnet_id      = aws_subnet.subpvt.id
  route_table_id = aws_route_table.rtpvt.id
}

#Public Security Group
resource "aws_security_group" "secpub" {
  name        = "Sec_pub"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "rdp"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Sec_pub"
  }
}
#Private Security Group
resource "aws_security_group" "secpvt" {
  name        = "Sec_pvt"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "All TCP"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.secpub.id}"]
    #cidr_blocks      = ["aws_security_group.secpub.ids"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Sec_pvt"
  }
}

# Elastic Ip Address
resource "aws_eip" "myeip" {
  vpc      = true
}

# Nat Gateway
resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.subpub.id

  tags = {
    Name = "gw NAT"
  }
}

# Public EC2 Instance Creation
resource "aws_instance" "webserver" {
  ami           = "ami-094bbd9e922dc515d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subpub.id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.secpub.id}"]
  tags = {
    Name = "webserver"
  }
}

# Private EC2 Instance Creation
resource "aws_instance" "db" {
  ami           = "ami-094bbd9e922dc515d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subpvt.id
  vpc_security_group_ids = ["${aws_security_group.secpvt.id}"]
  tags = {
    Name = "database"
  }
}


