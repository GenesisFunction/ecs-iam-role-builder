output "iam_role_id" {
  description = "ID of IAM Role created"
  value       = aws_iam_role.this.id
}

output "iam_role_arn" {
  description = "ARN of IAM Role created"
  value       = aws_iam_role.this.arn
}

