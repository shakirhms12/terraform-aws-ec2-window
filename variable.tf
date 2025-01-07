variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"  # Default value (optional)
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default = "ami-09ec59ede75ed2db7"
}
variable "region" {
  default = "us-east-1"
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true  # Mark as sensitive so it's not displayed in the logs
}

variable "cidr_vpc" {
  description = "CIDR Block value"
  default = "10.0.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR Block value"
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "install_software" {
  default = "IIS"
}

variable "vm_name" {
  default = "MyWindowsServer"
}