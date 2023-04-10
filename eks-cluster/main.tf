resource "aws_iam_role" "eks-iam-role" {
 name = "happystays-eks-role"

 path = "/"

 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}

resource "aws_eks_cluster" "happystays-eks-cluster" {
 name = "happystays-eks-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = [var.IBS-RnD-Sub1, var.IBS-RnD-Sub2, var.IBS-RnD-Sub3, var.IBS-RnD-Sub4]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}


resource "aws_iam_role" "happystays-workernodes" {
  name = "happystays-eks-node-group"

  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role    = aws_iam_role.happystays-workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role    = aws_iam_role.happystays-workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.happystays-workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.happystays-workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonDynamoDBFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role    = aws_iam_role.happystays-workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonRDSFullAccess" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
   role    = aws_iam_role.happystays-workernodes.name
  }


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.happystays-eks-cluster.name
  node_group_name = "happystays-eks-node-group"
  node_role_arn  = aws_iam_role.happystays-workernodes.arn
  subnet_ids   = [var.IBS-RnD-Sub1, var.IBS-RnD-Sub2]

  scaling_config {
   desired_size = 1
   max_size   = 2
   min_size   = 1
  }

  ami_type = "AL2_x86_64"
  instance_types = ["t2.small"]
  capacity_type = "ON_DEMAND"
  disk_size = 20

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
   aws_iam_role_policy_attachment.AmazonDynamoDBFullAccess,
   aws_iam_role_policy_attachment.EC2InstanceProfileForImageBuilderECRContainerBuilds,
   aws_iam_role_policy_attachment.AmazonRDSFullAccess
  ]
 }
