variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "force_destroy" {
  description = "Destroy bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
