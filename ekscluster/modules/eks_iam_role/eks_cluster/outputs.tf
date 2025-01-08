output "arn" {
    description = "eks cluster role arn."
	value = module.eks_cluster_role.arn
}