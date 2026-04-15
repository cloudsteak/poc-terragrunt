terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }
}

locals {
  subnet_map = {
    for subnet in var.subnets : subnet.name => subnet
  }
}

resource "aws_subnet" "this" {
  for_each = local.subnet_map

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
