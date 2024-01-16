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

resource "aws_instance" "web-server" {
  #arguments
  ami                          = data.aws_ami.ubuntu.id  
  instance_type                = "t3.micro"
  vpc_security_group_ids       = [aws_security_group.example.id]
  associate_public_ip_address  = true
  user_data = file("web-script.sh")
  key_name = aws_key_pair.deployer.key_name 
  

  tags = {
    Name = "my-web-ec2"
  }
}

# create key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


# create ebs volume
resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-2b"
  size              = 40

  tags = {
    Name = "my-terraform-volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web-server.id
}
