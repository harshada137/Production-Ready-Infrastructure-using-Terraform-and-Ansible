# Get latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Launch Template
resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "aws-eks"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-asg-instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.public.id]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "aws-eks"
    # key_name = "YOUR_EXISTING_KEYPAIR_NAME"
    value               = "web-tier"
    propagate_at_launch = true
  }
}
