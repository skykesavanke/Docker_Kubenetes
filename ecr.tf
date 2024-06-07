provider "aws" {
    region = variable.aws_region
  
}
resource "aws_ecr_repository" "example-repo" {
   name = variable.ecr_repo
   image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
