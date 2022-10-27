resource "aws_instance" "MyApp_Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_1_id
  availability_zone           = var.avail_zone
  vpc_security_group_ids      = [aws_security_group.MyApp_SG.id]
  associate_public_ip_address = true
  key_name                    = "EC2 Toturial"

#   user_data = file("Entry_Script.sh")

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





