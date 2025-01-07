module "eks_node_group_role" {
	source   = "../"
	name     = "${var.tags.Name}-nodegroup"
	policies = [
		"arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
		"arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
		"arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
	]
	trust    = "ec2"
	tags     = var.tags
}