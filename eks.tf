
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "main" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.aws_eks_cluster
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.main[*].id
  }

#   depends_on = [
#     aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController
#   ]
}



resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = var.aws_eks_cluster
  node_group_name = var.aws_eks_node_group
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.main[*].id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

#   depends_on = [
#     aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly
#   ]
