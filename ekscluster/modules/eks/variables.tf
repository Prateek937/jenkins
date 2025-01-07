variable "master_role_arn" {
  description = "iam_role_eks_cluster arn"
  type = string
}

variable "node_role_arn" {
  description = "iam_role_eks_node_group arn"
  type = string
}

variable "subnet_ids" {
  description = "subnet ids for eks_cluster and eks_node_groups"
  type = list
}

variable "security_group_ids" {
  description = "security group ids for eks_cluster and eks_node_groups"
  type = list
}

variable "node_groups" {
  description = "node group details"
  type = map
}

variable "tags" {
    description = "appropriate tags. these will be used to assign pods to particular node groups."
    type = map(string)
}