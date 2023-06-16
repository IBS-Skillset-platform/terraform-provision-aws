data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data external "getOIDC" {
  program = ["sh","../command.sh"]
}

output "oidc_id" {
  value = data.external.getOIDC.result.oidc_id
}

resource "aws_iam_role" "HappyStaysAmazonEKSClusterAutoscalerRole" {
  name = "HappyStaysAmazonEKSClusterAutoscalerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/${data.external.getOIDC.result.oidc_id}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "oidc.eks.ap-south-1.amazonaws.com/id/${data.external.getOIDC.result.oidc_id}:aud" : "sts.amazonaws.com",
            "oidc.eks.ap-south-1.amazonaws.com/id/${data.external.getOIDC.result.oidc_id}:sub" : "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "autoscaler_policy_document" {
  statement {
    sid = "VisualEditor0"
    actions   = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    resources = ["*"]
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/happystays-eks-cluster"
      values   = ["owned"]
    }
  }
  statement {
    sid = "VisualEditor1"
    actions   = [
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeAutoScalingGroups",
      "ec2:DescribeLaunchTemplateVersions",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeLaunchConfigurations",
      "ec2:DescribeInstanceTypes"
    ]
    resources = ["*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "autoscaler_policy" {
  name        = "HappyStaysAmazonEKSClusterAutoscalerPolicy"
  description = "Policy for autoscaler"
  policy      = data.aws_iam_policy_document.autoscaler_policy_document.json
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.HappyStaysAmazonEKSClusterAutoscalerRole.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn
}