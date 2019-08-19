# ecs-iam-role-builder
ecs-iam-role-builder helps create an iam role with or without a custom policy(ies). It adds cloudwatch log rights to IAM as well as being able to attach custom policies

### Example Usage:
Create a default role with permissions for ssm and cloudwatch agent:
```
module "ecs_default_iam_role" {
  source  = "GenesisFunction/ecs-iam-role-builder/aws"
  version = "1.0.0"
  # source  = "github.com/GenesisFunction/terraform-aws-ecs-iam-role-builder"

  cloudwatch_logs_policy     = true
  cloudwatch_logs_group_path = "/ecs/group-name"

  ecr_policy = true
  ecr_repos  = [
    aws_ecr_repository.this.arn
  ]
  
  role_name  = "${var.name_prefix}-default-ecs-iam-role${local.full_suffix}"
  input_tags = merge(local.common_tags, {})
}
```

Create a role with custom permissions in addition to ssm and cloudwatch agent permissions:
```
module "ecs_default_iam_role" {
  source  = "GenesisFunction/ecs-iam-role-builder/aws"
  version = "1.0.0"
  # source  = "github.com/GenesisFunction/terraform-aws-ecs-iam-role-builder"

  cloudwatch_logs_policy     = true
  cloudwatch_logs_group_path = "/ecs/group-name"

  ecr_policy = true
  ecr_repos  = [
    aws_ecr_repository.this.arn
  ]
  
  role_name = "${var.name_prefix}-default-ecs-iam-role${local.full_suffix}"
  custom_policy_jsons    = ["${data.aws_iam_policy_document.my_custom_instance_policy.json}"]
  input_tags            = merge(local.common_tags, {})
}
```
  
