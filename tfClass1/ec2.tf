#Provider for AWS
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "test-nargiza" {
  ami           = "ami-0cd3c7f72edd5b06d"
  instance_type = "t2.small"
  tags = {
    Name = "tf-test"
  }
}

