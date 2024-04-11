data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "instanceprofile" {

  statement {
    effect = "Allow"
    resources = ["*"]
    actions = ["ec2:*", "ecr:*", "autoscaling:*", "elasticloadbalancing:*", "tag:*", "ssm:GetParameter", "kms:Decrypt" ]
  }

}
