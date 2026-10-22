variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ssh_ingress_cidrs" {
  description = "CIDR ranges allowed to SSH/HTTP (for demo keep 0.0.0.0/0)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

