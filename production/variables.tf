variable "subscription_id" {
  description = "Azure subscription ID used by the AzureRM provider."
  type        = string
}

variable "admin_group_object_ids" {
  description = "Entra ID group object IDs that receive AKS cluster admin access."
  type        = list(string)
}

variable "gitops_repo_path" {
  description = "Local path where Terraform writes generated GitOps manifests."
  type        = string
}

variable "flux_ssh_private_key_path" {
  description = "Local path to the SSH private key used by the Flux extension."
  type        = string
}
