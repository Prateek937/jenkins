module "eks_cluster_role" {
	source   = "../"
	name     = "${var.tags.Name}-master"
	policies = [
		"arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
		"arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
	]
	trust    = "eks"
	tags     = var.tags
}