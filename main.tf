#1 provider
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

#instance
resource "aws_instance" "windows" {
  ami           = "ami-05b4ded3ceb71e470" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_aws.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name = "my_aws_key"

   # Upload PowerShell script
  provisioner "file" {
    source      = templatefile("${path.module}/windows-setup.ps1.tpl", {
      vm_name         = var.vm_name
      install_software = var.install_software
    })
    destination = "C:\\setup\\windows-setup.ps1"

     connection {
      type     = "winrm"
      host     = aws_instance.windows.public_ip
      user     = "Administrator"
      password = var.password  # Use a secure method to retrieve this password
      https    = false
      insecure = true
      port     = 5985
    }
  }

  # Execute PowerShell script
  provisioner "remote-exec" {
    inline = [
      "powershell.exe -ExecutionPolicy Bypass -File C:\\setup\\windows-setup.ps1"
    ]
  }
  # Add tags to the instance
  tags = {
    Name        =  "windows"                               # "webserver-${terraform.workspace}"
    # Environment = 
    # Branch      = terraform.workspace
  }
}