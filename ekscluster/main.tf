provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_endpoint_public_access = true
  cluster_version = "1.31"
  subnet_ids     = var.subnet_ids
  vpc_id          = var.vpc_id

#    # EKS Managed Node Group(s)
#   eks_managed_node_group_defaults = {
#     instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
#   }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 2
      desired_size = 2
    }
  }
}
