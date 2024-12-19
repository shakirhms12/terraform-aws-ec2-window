#1 provider
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

#2vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

#security group
resource "aws_security_group" "security_group" {
    vpc_id = aws_vpc.my_vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#subnet
resource "aws_subnet" "subnet_aws" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "my_subnet"
  }
}
#instance
resource "aws_instance" "windows" {
  ami           = "ami-012485deee5681dc0" # Example for Amazon Linux 2 in us-east-1 region
  instance_type = "t2.micro"
 subnet_id = aws_subnet.subnet_aws.id
 vpc_security_group_ids = [aws_security_group.security_group.id]
  # Key pair to connect to your instance (replace with your actual key)
  key_name = "my_aws_key"
  # Add tags to the instance
  tags = {
    Name        = "webserver-${terraform.workspace}"
    Environment = terraform.workspace
    Branch      = terraform.workspace
  }
}