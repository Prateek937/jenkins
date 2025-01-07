variable "cluster_name" {
  default = "test-cluster"
}
variable "subnet_ids" {
  default = ["subnet-0ed454b2be601fe92", "subnet-0614c7c306883de4c", "subnet-06a0b83bec19d1144"]
}

variable "vpc_id" {
  default = "vpc-0b448e60"
}

variable "security_group_ids" {
  default = ["sg-1e994361"]
}

variable "node_groups" {
  default = {
    node1 : {
      desired_size = 1
      max_size     = 2
      min_size     = 1
    }
  }
}