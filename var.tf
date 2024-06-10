variable "aws_region" {
        description = "This describe the region"
        type = string
        default = ""
  
}
variable "ecr_repo" {
        description = "This defines the repository"
        type =string
        default = "cluster_repo"
  
}