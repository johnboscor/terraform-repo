provider "aws" {
  region = "us-west-2"
}
resource "aws_iam_user" "test123" {
  name = "test123"
  tags = {
    Type = "Test user for terraform"
  }
}
