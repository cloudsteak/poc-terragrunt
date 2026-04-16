variable "vpc_id" {
  description = "VPC ID where subnets are created."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "The vpc_id must be a valid AWS VPC ID."
  }
}

variable "subnets" {
  description = "Subnet definitions."
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))

  validation {
    condition     = length(var.subnets) > 0
    error_message = "At least one subnet must be provided."
  }

  validation {
    condition     = length(distinct([for s in var.subnets : s.name])) == length(var.subnets)
    error_message = "Subnet names must be unique."
  }

  validation {
    condition     = length(distinct([for s in var.subnets : s.cidr_block])) == length(var.subnets)
    error_message = "Subnet CIDR blocks must be unique."
  }

  validation {
    condition     = alltrue([for s in var.subnets : can(cidrhost(s.cidr_block, 0))])
    error_message = "Every subnet CIDR block must be a valid IPv4 CIDR."
  }

  validation {
    condition     = alltrue([for s in var.subnets : can(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", s.availability_zone))])
    error_message = "Every availability_zone must match the expected AWS AZ format, for example eu-central-1a."
  }
}

variable "tags" {
  description = "Tags applied to all subnet resources."
  type        = map(string)
  default     = {}
}
