# 1. Create Ubuntu server and install docker
resource "aws_instance" "web_server_instance_1" {
  ami               = "ami-0c38b837cd80f13bb"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "main-key"

  iam_instance_profile = aws_iam_instance_profile.s3_access_instance_profile.name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web_server_nic_1.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo docker run -d -p 80:80 -e AWS_ACCESS_KEY_ID=${var.aws_access_key} -e AWS_SECRET_ACCESS_KEY=${var.aws_secret_key} asmartishin/my-flask-upload-app:latest
                EOF

  tags = {
    Name = "web-server"
  }
}

# 2. Define a second server
resource "aws_instance" "web_server_instance_2" {
  ami               = "ami-0c38b837cd80f13bb"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1b"
  key_name          = "main-key"

  iam_instance_profile = aws_iam_instance_profile.s3_access_instance_profile.name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web_server_nic_2.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo docker run -d -p 80:80 -e AWS_ACCESS_KEY_ID=${var.aws_access_key} -e AWS_SECRET_ACCESS_KEY=${var.aws_secret_key} <your-dockerhub-username>/my-flask-upload-app:latest
                EOF

  tags = {
    Name = "web-server-2"
  }
}

# 3. Create a network interfaces with ips in the subnets
resource "aws_network_interface" "web_server_nic_1" {
  subnet_id       = aws_subnet.subnet_1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_network_interface" "web_server_nic_2" {
  subnet_id       = aws_subnet.subnet_2.id
  private_ips     = ["10.0.2.50"]
  security_groups = [aws_security_group.allow_web.id]
}

# 4. Assign an elastic IP to the network interfaces
resource "aws_eip" "web_server_1" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web_server_nic_1.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.gw]
}

resource "aws_eip" "web_server_2" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web_server_nic_2.id
  associate_with_private_ip = "10.0.2.50"
  depends_on                = [aws_internet_gateway.gw]
}
