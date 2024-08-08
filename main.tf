variable "docker_image" {
  description = "Docker image to deploy"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0ad21ae1d0696ad58"  # Replace with your desired AMI
  instance_type = "t2.micro"
  key_name      = "logesh"

  user_data = <<-EOF
              #!/bin/bash
              docker run -d --name myapp -p 80:80 ${var.docker_image}
              EOF

  tags = {
    Name = "MyAppInstance"
  }
}

output "instance_ip" {
  value = aws_instance.app.public_ip
}
