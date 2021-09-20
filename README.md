<!-- BEGIN_TF_DOCS -->
# ecs-iam-role-builder
ecs-iam-role-builder helps create an iam role with or without a custom policy(ies). It adds cloudwatch log rights to IAM as well as being able to attach custom policies

---

### Example Usage
Create a default role with permissions for ssm and cloudwatch agent

```hcl
module "ecs_default_iam_role" {
  source  = "StratusGrid/ecs-iam-role-builder/aws"
  version = ">= 1.0"
  # source  = "github.com/StratusGrid/terraform-aws-ecs-iam-role-builder"

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

Create a role with custom permissions in addition to ssm and cloudwatch agent permissions

```hcl
module "ecs_default_iam_role" {
  source  = "StratusGrid/ecs-iam-role-builder/aws"
  version = ">= 1.0"
  # source  = "github.com/StratusGrid/terraform-aws-ecs-iam-role-builder"

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
---

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_logs_group_path"></a> [cloudwatch\_logs\_group\_path](#input\_cloudwatch\_logs\_group\_path) | Path to cloudwatch logs group which containers should create new log streams in | `string` | n/a | yes |
| <a name="input_cloudwatch_logs_policy"></a> [cloudwatch\_logs\_policy](#input\_cloudwatch\_logs\_policy) | True/False to attach permissions to CloudWatch Logs. If true (default), should also define cloudwatch\_logs\_group\_path. If you need to have multiple groups (one per container for instance), you can do this by nesting them under a parent and doing something like /ecs/parent/* | `bool` | `true` | no |
| <a name="input_custom_policy_jsons"></a> [custom\_policy\_jsons](#input\_custom\_policy\_jsons) | List of JSON strings of custom policies to be attached to the ecs iam role | `list(string)` | `[]` | no |
| <a name="input_ecr_policy"></a> [ecr\_policy](#input\_ecr\_policy) | True/False to attach permissions for ECR. If true (default), should also define ecr\_repo | `bool` | `false` | no |
| <a name="input_ecr_repos"></a> [ecr\_repos](#input\_ecr\_repos) | List of ARNs to ECR repos that the tasks should be able to pull images from | `list(string)` | `null` | no |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Unique string name of iam role to be created. Also prepends supporting resource names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM Role created |
| <a name="output_iam_role_id"></a> [iam\_role\_id](#output\_iam\_role\_id) | ID of IAM Role created |

---

## Contributors
- Chris Hurst [GenesisChris](https://github.com/GenesisChris)
- Ivan Casco [ivancasco-sg](https://github.com/ivancasco-sg)
- Jason Drouhard [jason-drouhard](https://github.com/jason-drouhard)
- Juan Sanches [juansanchezv](https://github.com/juanssanchezv)

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->