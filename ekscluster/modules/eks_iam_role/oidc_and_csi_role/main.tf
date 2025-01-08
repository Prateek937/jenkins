resource "aws_iam_openid_connect_provider" "eks" {
  url = var.oidc_issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]
}

resource "aws_iam_role" "csi_driver_role" {
  name = "csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "${aws_iam_openid_connect_provider.eks.arn}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${split("er/", aws_iam_openid_connect_provider.eks.arn)[1]}:aud" = "sts.amazonaws.com",
            "${split("er/", aws_iam_openid_connect_provider.eks.arn)[1]}:sub" = "system:serviceaccount:default:${var.service_account_name}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.csi_driver_role.name
  policy_arn = var.policy_arn
}