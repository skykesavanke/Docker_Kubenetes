variable "aws_region" {
  description = "This describe the region"
  type        = string
  default     = "us-east-1"

}
variable "ecr_repo" {
  description = "This defines the repository"
  type        = string
  default     = "cluster_repo"

}
variable "aws_eks_cluster" {
  description = "This defines the eks cluster"
  type        = string
  default     = "cluster"

}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "aws_eks_node_group" {
  description = "This defines the eks cluster"
  type        = string
  default     = "node-group"

}
variable "aws_security_group" {
  description = "This defines the security group"
  type        = string
  default     = "cluster-security-group"

}


