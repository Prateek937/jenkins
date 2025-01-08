output "arn" {
    description = "node group role arn"
	value = module.eks_node_group_role.arn
}