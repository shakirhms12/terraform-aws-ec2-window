output "instance_id" {
  value = aws_instance.windows.id
}

output "subnet_id"{
    value = aws_subnet.subnet_aws.id
}

output "vpc_id"{
    value = aws_vpc.vpc.id
}