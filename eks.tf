
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "main" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-subnet-${count.index}"
    "kubernetes.io/cluster/my-cluster" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}
data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.aws_eks_cluster
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.main[*].id
    endpoint_public_access  = true
    endpoint_private_access = false
    public_access_cidrs     = ["0.0.0.0/0"]
  }
  }






resource "aws_eks_node_group" "eks_node_grp" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.aws_eks_node_group
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids  =aws_subnet.main[*].id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
    update_config {
    max_unavailable = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]


ami_type = "AL2_x86_64"
instance_types = ["t3.medium"]


  remote_access {
    source_security_group_ids = [aws_security_group.cluster_security_group.id]  
    ec2_ssh_key = "first"
}
}
resource "aws_security_group" "cluster_security_group" {
  vpc_id = aws_vpc.main.id
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-sg"
  }
}