#Creating EC2
resource "aws_instance" "nginxserver" {
  ami           = "ami-0189c3f216088b7db"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [ aws_security_group.nginx-sg.id ]
  associate_public_ip_address = true
  

  user_data = <<-EOF
                 #!/bin/bash
                 sudo yum install nginx -y
                 systemctl start nginx
                 EOF

  tags = {
    Name = "Nginx Server"
  }
}