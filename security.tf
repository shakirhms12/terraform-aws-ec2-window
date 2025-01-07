#security group
resource "aws_security_group" "security_group" {
    vpc_id = aws_vpc.vpc.id
    
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

      # Ingress (RDP access on port 3389)
   ingress {
       from_port   = 3389
       to_port     = 3389
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]  # Allow RDP access from any IP (consider restricting to specific IPs)
   }
}