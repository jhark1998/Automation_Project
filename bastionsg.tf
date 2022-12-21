resource "aws_security_group" "bastion-host1998_SG" {
  name        = "bastion-host1998_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.rishi1998.id

  ingress {
    description      = "ssh from bastion"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["49.43.42.187/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow ssh"
  }
}