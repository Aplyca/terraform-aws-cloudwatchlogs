output "name" {
  description = "Name of log group"
  value       = "${aws_cloudwatch_log_group.this.name}"
}

output "policy_arn" {
  value       = "${aws_iam_policy.this.arn}"
  description = "ARN of policy of CloudWatch log"
}
