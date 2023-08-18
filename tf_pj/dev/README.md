
[](https://github.com/terraform-aws-modules/terraform-aws-eks)

```
module.eks.aws_iam_role.this[0]: Creating...
module.eks.aws_iam_role.this[0]: Still creating... [10s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [20s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [30s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [40s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [50s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m0s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m10s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m20s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m30s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m40s elapsed]
module.eks.aws_iam_role.this[0]: Still creating... [1m50s elapsed]
╷
│ Error: creating IAM Role (education-eks-4ukZvLjt-cluster-20230817013705035400000001): MalformedPolicyDocument: Invalid principal in policy: "SERVICE":"eks.amazonaws.com.cn"
│ 	status code: 400, request id: 184f6cbd-703c-4882-a267-a6ea6916cb49
│ 
│   with module.eks.aws_iam_role.this[0],
│   on .terraform/modules/eks/main.tf line 285, in resource "aws_iam_role" "this":
│  285: resource "aws_iam_role" "this" {
│ 
╵
ubuntu@ip-10-1-0-88:~/tf_demo/tf_pj/dev$ 

```
[修复：中国分区 OIDC 提供商中的 STS 受众错误](https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2271)
