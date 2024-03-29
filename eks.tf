locals {
  node_group_name        = "${local.cluster_name}-node-group"
  iam_role_policy_prefix = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy"
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = local.cluster_name
  cluster_version                 = "1.27"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cloudwatch_log_group_retention_in_days = 1

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64" # 
    disk_size              = 10           # EBS 사이즈
    instance_types         = ["t2.small"]
    # vpc_security_group_ids = [aws_security_group.additional.id]
    vpc_security_group_ids = []
		
		# cluster-autoscaler에 사용 될 IAM 등록
    iam_role_additional_policies = ["${local.iam_role_policy_prefix}/${module.iam_policy_autoscaling.name}"]
  }

  eks_managed_node_groups = {
    ("${local.cluster_name}-node-group") = {
      # node group 스케일링
      min_size     = 1 # 최소
      max_size     = 3 # 최대
      desired_size = 2 # 기본 유지

      # 생성된 node에 labels 추가 (kubectl get nodes --show-labels로 확인 가능)
      labels = {
        ondemand = "true"
      }

      # 생성되는 인스턴스에 tag추가
      tags = {
        "k8s.io/cluster-autoscaler/enabled" : "true"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" : "true"
      }
    }
  }

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "kube-system"
        },
        {
          namespace = "default"
        }
      ]
    }
  }
}