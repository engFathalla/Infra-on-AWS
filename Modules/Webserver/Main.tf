resource "aws_instance" "MyApp_Server" {
  ami                         = "ami-0149b2da6ceec4bb0"
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_1_id
  availability_zone           = var.avail_zone
  vpc_security_group_ids      = [aws_security_group.MyApp_SG.id]
  associate_public_ip_address = true
  key_name                    = "EC2 Toturial"

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
docker run --name=Nginx -p 8080:80 -d nginx:latest 
EOF

  tags = {
    "Name" = "${var.prefix_env}_server"
  }
}

resource "aws_security_group" "MyApp_SG" {
  name   = "MyApp_SG"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    "Name" = "${var.prefix_env}_SSH_HTTP"
  }

}





