

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "environment" {
  description = "Runtime Environment such as default, develop, stage, production"
  type        = string
  default = "dev"
}

variable "lock_table_name" {
  default = "dynamo db locking table name"
  type    = string
}