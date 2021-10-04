/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

module "aws_eks_self_managed_node_groups" {
  source = "./modules/aws-eks-self-managed-node-groups"

  for_each = { for key, value in var.self_managed_node_groups : key => value
    if var.enable_self_managed_nodegroups && length(var.self_managed_node_groups) > 0
  }

  self_managed_ng = each.value

  eks_cluster_name  = module.aws_eks.cluster_id
  cluster_endpoint  = module.aws_eks.cluster_endpoint
  cluster_ca_base64 = module.aws_eks.cluster_certificate_authority_data
  tags              = module.eks_tags.tags

  vpc_id             = var.create_vpc == false ? var.vpc_id : module.aws_vpc.vpc_id
  private_subnet_ids = var.create_vpc == false ? var.private_subnet_ids : module.aws_vpc.private_subnets
  public_subnet_ids  = var.create_vpc == false ? var.public_subnet_ids : module.aws_vpc.public_subnets

  worker_security_group_id          = module.aws_eks.worker_security_group_id
  cluster_security_group_id         = module.aws_eks.cluster_security_group_id
  cluster_primary_security_group_id = module.aws_eks.cluster_primary_security_group_id

  kubernetes_version = var.kubernetes_version

  depends_on = [module.aws_eks, kubernetes_config_map.aws_auth]

}