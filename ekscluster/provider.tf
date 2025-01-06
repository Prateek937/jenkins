terraform {
  backend "s3" {
    bucket = "jenkins-test-terraform1"
    key = "state"
    region = "ap-south-1"
    dynamodb_table = "jenkins-test-terraform1"
  }
}