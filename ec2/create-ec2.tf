provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "http_server" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0945cbacbab9f7e02"
  key_name      = "john"
  user_data     = <<EOF
		#! /bin/bash
                sudo yum install -y httpd
		sudo systemctl start httpd
		sudo systemctl enable httpd
		echo "<h1>Deployed via Terraform - John!</h1>" | sudo tee /var/www/html/index.html
                sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
                sudo systemctl restart sshd   
                sudo echo -n 'c1sc0!@#' | passwd --stdin ec2-user
	EOF

  tags = {
    Name = "HelloWorld-John"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.http_server.public_ip
}
