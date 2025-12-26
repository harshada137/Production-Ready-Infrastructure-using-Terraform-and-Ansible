resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  key_name                    = "aws-eks"
  associate_public_ip_address = false

  tags = {
    Name = "app-server"
  }
}
