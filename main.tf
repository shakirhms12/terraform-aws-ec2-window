#1 provider
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

#instance
resource "aws_instance" "windows" {
  ami           = "ami-012485deee5681dc0" # Example for Amazon Linux 2 in us-east-1 region
  instance_type = "t2.micro"
 subnet_id = aws_subnet.subnet_aws.id
 vpc_security_group_ids = [aws_security_group.security_group.id]
  # Key pair to connect to your instance (replace with your actual key)
  key_name = "my_aws_key"

  user_data = <<-EOF
              <powershell>
              # Install IIS (Internet Information Services) on Windows
              Install-WindowsFeature -Name Web-Server -IncludeManagementTools

              # Start IIS Service (if not already started)
              Start-Service -Name W3SVC

              # Confirm IIS installation
              Get-Service -Name W3SVC
              </powershell>
            EOF
  # Add tags to the instance
  tags = {
    Name        =  "windows"                               # "webserver-${terraform.workspace}"
    # Environment = 
    # Branch      = terraform.workspace
  }
}