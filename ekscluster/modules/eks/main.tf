resource "aws_eks_cluster" "this" {
	name     = var.tags.Name
	role_arn = var.master_role_arn
	vpc_config {
		subnet_ids         = var.subnet_ids
		security_group_ids = var.security_group_ids
	}
	tags = var.tags
}

resource "aws_eks_node_group" "this" {
    for_each = var.node_groups
	node_group_name = each.key
	node_role_arn   = var.node_role_arn 
	cluster_name    = aws_eks_cluster.this.name
	subnet_ids      = var.subnet_ids
	# instance_types  = try(each.value.instance_types, null) 
	scaling_config {
        min_size       = each.value.min_size
		desired_size   = each.value.desired_size
		max_size       = each.value.max_size
	}

	tags = var.tags
}