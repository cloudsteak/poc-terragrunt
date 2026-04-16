variable "name" {
  description = "VPC name."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "The VPC name must not be empty."
  }
}

variable "cidr_block" {
  description = "IPv4 CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "The VPC cidr_block must be a valid IPv4 CIDR."
  }
}

variable "tags" {
  description = "Tags applied to all VPC resources."
  type        = map(string)
  default     = {}
}
