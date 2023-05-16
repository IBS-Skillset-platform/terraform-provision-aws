terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "happystays-terraform-state"
    key            = "eks/s3/terraform.tfstate"
    region         = var.region

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}