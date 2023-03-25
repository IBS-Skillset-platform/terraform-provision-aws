#Resource to create dynamodb table
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Properties"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = {
    Environment       = "RnD"
    Project           = "Skillset"
    Name              = "HappyStays"
    CostCenter        = "CDx"
  }
}