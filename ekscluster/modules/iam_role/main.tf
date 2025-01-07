resource "aws_iam_role" "this" {
	name               = var.name
	assume_role_policy = <<POLICY
{
	"Version": "2012-10-17",
	"Statement": [{
		"Effect": "Allow",
		"Principal": {
			"Service": "${var.trust}.amazonaws.com"
		},
		"Action": "sts:AssumeRole"
	}]
}
POLICY
	tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
	for_each   = toset(var.policies)
	policy_arn = each.key
	role       = aws_iam_role.this.name
}