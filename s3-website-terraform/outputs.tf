output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.static_website.bucket
}
output "static_website_url" {
  value = "http://${aws_s3_bucket.static_website.website_endpoint}/index.html"
}


output "uploaded_files" {
  description = "List of uploaded files in the S3 bucket"
  value       = [for f in aws_s3_object.files_upload : f.key]
}

output "uploaded_img_files" {
  description = "List of uploaded image files in the S3 bucket"
  value       = [for f in aws_s3_object.img_files_upload : f.key]
}
