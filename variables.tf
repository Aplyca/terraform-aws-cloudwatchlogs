variable "name" {
  description = "Name prefix for all CloudWatch Logs resources"
  default     = "App"
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  default     = 0
}

variable "streams" {
  description = "Group log streams names"
  default     = []
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "additional_permissions" {
  default = [
    "logs:CreateLogStream",
    "logs:DeleteLogStream",
  ]

  type        = list
  description = "Additional permissions granted to assumed role"
}

variable "description" {
  description = "Description of policy"
  default     = ""
}

variable "role" {
  description = "Role name"
  default     = ""
}
