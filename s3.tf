provider "aws" {
 region = "us-east-1"

}



resource "aws_s3_bucket" "b" {
  bucket = "rishi1998-bucket"


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}