provider "aws" {
    region = var.aws_region
  
}
resource "aws_ecr_repository" "example-repo" {
  name = var.aws_ecr_repo
   image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}