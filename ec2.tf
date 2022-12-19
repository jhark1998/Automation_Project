resource "aws_instance" "Bastion" {

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.rishi1998-public-subnet-1a.id
  security_groups        = [aws_security_group.bastion-host1998_SG.id]

  tags = {
    Sg  = "bastion"
  }
}

resource "aws_instance" "Jenkins" {

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t3.small"

  subnet_id              = aws_subnet.rishi1998-private-subnet-1a.id
  security_groups        = [aws_security_group.private_SG.id]


  tags = {
    Sg  = "jenkins"
}
}
resource "aws_instance" "App" {

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.rishi1998-private-subnet-1b.id
  security_groups        = [aws_security_group.Public-web_SG.id]


  tags = {
    Sg  = "App"
  }
}