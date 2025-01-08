output "name" {
    description = "name of the cluster"
	value = aws_eks_cluster.this.name
}

output "endpoint" {
    description = "cluster endpoint"
	value = aws_eks_cluster.this.endpoint
}

output "oidc_issuer" {
    description = "oidc_issuer_url"
    value = aws_eks_cluster.this.identity.0.oidc.0.issuer
}