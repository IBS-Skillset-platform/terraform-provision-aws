resource "aws_secretsmanager_secret" "happystays_secret" {
  name = "/secret/happystays"
}

resource "aws_secretsmanager_secret_version" "happystays_secret_version" {
  secret_id     = aws_secretsmanager_secret.happystays_secret.id
  secret_string = jsonencode(var.secrets)
}