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

output "self_managed_node_group_name" {
  description = "EKS Self Managed node group id"
  value       = local.self_managed_node_group["node_group_name"].*
}

output "self_managed_node_group_iam_role_arns" {
  description = "Self managed groups IAM role arns"
  value       = aws_iam_role.self_managed_ng[*].arn
}

output "self_managed_iam_role_name" {
  description = "Self managed groups IAM role names"
  value       = aws_iam_role.self_managed_ng[*].name
}

output "self_managed_sec_group_id" {
  description = "Self managed group security group id/ids"
  value       = var.worker_security_group_id == "" ? aws_security_group.self_managed_ng[*].id : [var.worker_security_group_id]
}

output "self_managed_asg_name" {
  description = "Self managed group ASG names"
  value       = aws_autoscaling_group.self_managed_ng[*].name
}

output "launch_template_latest_versions" {
  description = "launch templated version for EKS Self Managed Node Group"
  value       = aws_launch_template.self_managed_ng[*].latest_version
}

output "launch_template_ids" {
  description = "launch templated id for EKS Self Managed Node Group"
  value       = aws_launch_template.self_managed_ng[*].id
}

output "launch_template_arn" {
  description = "launch templated id for EKS Self Managed Node Group"
  value       = aws_launch_template.self_managed_ng[*].arn
}