variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-ea`"

}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

}

variable "mime_types" {
  default = {
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
  }
}