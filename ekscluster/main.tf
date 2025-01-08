provider "aws" {
  region = "ap-south-1"
}

module "master_role" {
  source = "./modules/eks_iam_role/eks_cluster"
  tags = {
    Name : "test-cluster"
  }
}

module "node_group_role" {
  source = "./modules/eks_iam_role/eks_node_group"
  tags = {
    Name : "test-cluster"
  }
}
module "eks" {
  source          = "./modules/eks"
  master_role_arn = "${module.master_role.arn}"
  node_role_arn = module.node_group_role.arn
  subnet_ids     = var.subnet_ids
  security_group_ids = var.security_group_ids
  node_groups = var.node_groups
  tags = {
    Name = "test-cluster"
  }
}

module "oidc_and_csi_role" {
  source = "./modules/eks_iam_role/oidc_and_csi_role"
  oidc_issuer = module.eks.oidc_issuer
  service_account_name = "csi-sa"
  policy_arn = "arn:aws:iam::025932243242:policy/CSI-eks-secret-manager"
}
