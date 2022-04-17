resource "aws_key_pair" "server" {
  key_name   = "${var.vpc_name}-provision-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCe5QOSSYGpeujBANrTk+KwJHV5PFyB4QZ26+q0RONxQe7Fo4johycZkQFn8dGFhsDnAoZUlp4nyNjSkgX2I0b2y32E3Bqy2mX+vU+12fJH5ZHPyHKHX7jQb2iAwBlrzXwC73WNIcU+bb0NGc9ctEPQxsGUgMtG5aXVOLJeKEvLoztGGHcqe8o2Ado6+1r+V/PPOFMES9xDkdHjpru01TETVrldB6OWHRnS3yIDkaQhMYkFa9TJhY0GeMJzvMm38lXyv15WnJJ8NC+YrR/sGIxvfT10Lc7hMQHVnPWVS4GdCLhQEKxcLnxeS1PNRj5XhljYBExLCBDW5UzUpebipv+f imported-openssh-key"
}

resource "aws_instance" "server" {
  ami                         = "ami-07d02ee1eeb0c996c"
  availability_zone           = "us-east-1a"
  instance_type               = "t3.micro"
  key_name                    = "${var.vpc_name}-provision-key"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.devs-remote-login-in.id]
  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
  }
  tags = {
    Name = "server-portal-covid"
  }
}