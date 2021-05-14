resource "aws_instance" "go_web_app" {
  ami           = "ami-09e67e426f25ce0d7"
  key_name = "my-server"
  instance_type = "t2.micro"
  security_groups= [ "gowebapp_security_group"]
  tags= {
    Name = "go_web_app"
  }
}

#Create security group with firewall rules

resource "aws_security_group" "gowebapp_security_group" {
  name        = "gowebapp_security_group"
  description = "security group for jenkins"

  ingress {
    from_port   = 9009
    to_port     = 9009
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "gowebapp_security_group"
  }
}
 
# Create Elastic IP address
resource "aws_eip" "go_web_app" {
  vpc      = true
  instance = aws_instance.go_web_app.id
tags= {
    Name = "go_web_app_elastic_ip"
  }
}