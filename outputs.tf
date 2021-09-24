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


output "cluster_oidc_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = var.create_eks ? split("//", module.eks.eks_cluster_oidc_issuer_url)[1] : "EKS Cluster not enabled"
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`."
  value       = var.create_eks ? module.eks.oidc_provider_arn : "EKS Cluster not enabled"
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.create_eks ? module.eks.eks_cluster_id : "EKS Cluster not enabled"
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.create_eks ? "aws eks --region ${data.aws_region.current.id} update-kubeconfig --name ${module.eks.eks_cluster_id}" : "EKS Cluster not enabled"
}

output "amp_work_id" {
  value = var.prometheus_enable ? module.aws_managed_prometheus[0].amp_workspace_id : "AMP not enabled"
}

output "amp_work_arn" {
  value = var.prometheus_enable ? module.aws_managed_prometheus[0].service_account_amp_ingest_role_arn : "AMP not enabled"
}

//output "self_managed_node_group_iam_role_arns" {
//  description = "IAM role arn's of self managed node groups"
//  value       = var.create_eks && var.enable_self_managed_nodegroups ? { for nodes in sort(keys(var.self_managed_node_groups)) : nodes => module.aws-eks-self-managed-node-groups[nodes].self_managed_node_group_iam_role_arns } : null
//}

output "managed_node_group_iam_role_arns" {
  description = "IAM role arn's of self managed node groups"
  value       = var.create_eks && var.enable_managed_nodegroups ? { for nodes in sort(keys(var.managed_node_groups)) : nodes => module.managed-node-groups[nodes].manage_ng_iam_role_arn } : null
}

output "managed_node_groups" {
  description = "Outputs from EKS node groups "
  value       = var.create_eks && var.enable_managed_nodegroups ? module.managed-node-groups.* : []
}

output "fargate_profiles" {
  description = "Outputs from EKS node groups "
  value       = var.create_eks && var.enable_fargate ? module.fargate-profiles.* : []
}

output "fargate_profiles_iam_role_arns" {
  description = "IAM role arn's of Fargate Profiles"
  value       = var.create_eks && var.enable_fargate ? { for nodes in sort(keys(var.fargate_profiles)) : nodes => module.fargate-profiles[nodes].eks_fargate_profile_role_name } : null
}

output "self_managed_node_group_aws_auth_config_map" {
  value = local.self_managed_node_group_aws_auth_config_map.*
}

output "windows_node_group_aws_auth_config_map" {
  value = local.windows_node_group_aws_auth_config_map.*
}

output "managed_node_group_aws_auth_config_map" {
  value = local.managed_node_group_aws_auth_config_map.*
}

output "fargate_profiles_aws_auth_config_map" {
  value = local.fargate_profiles_aws_auth_config_map.*
}

output "cluster_security_group_id" {
  value = module.eks.eks_cluster_security_group_id
}

output "cluster_primary_security_group_id" {
  value = module.eks.eks_cluster_primary_security_group_id
}

output "worker_security_group_id" {
  value = module.eks.eks_worker_security_group_id
}