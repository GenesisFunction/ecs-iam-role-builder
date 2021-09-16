variable "role_name" {
  description = "Unique string name of iam role to be created. Also prepends supporting resource names"
  type        = string
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default = {
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
  }
}

variable "cloudwatch_logs_policy" {
  description = "True/False to attach permissions to CloudWatch Logs. If true (default), should also define cloudwatch_logs_group_path. If you need to have multiple groups (one per container for instance), you can do this by nesting them under a parent and doing something like /ecs/parent/*"
  type        = bool
  default     = true
}

variable "cloudwatch_logs_group_path" {
  description = "Path to cloudwatch logs group which containers should create new log streams in"
  type        = string
}

variable "ecr_policy" {
  description = "True/False to attach permissions for ECR. If true (default), should also define ecr_repo"
  type        = bool
  default     = false
}

variable "ecr_repos" {
  description = "List of ARNs to ECR repos that the tasks should be able to pull images from"
  type        = list(string)
  default     = null
}

variable "custom_policy_jsons" {
  description = "List of JSON strings of custom policies to be attached to the ecs iam role"
  type        = list(string)
  default     = []
}

