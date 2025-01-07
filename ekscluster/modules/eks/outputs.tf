output "name" {
    description = "name of the cluster"
	value = aws_eks_cluster.this.name
}

output "endpoint" {
    description = "cluster endpoint"
	value = aws_eks_cluster.this.endpoint
}