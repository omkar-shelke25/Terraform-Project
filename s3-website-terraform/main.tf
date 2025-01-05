resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name # Make the bucket publicly readable
}

resource "aws_s3_object" "files_upload" {
  for_each = fileset("website", "*")

  bucket       = aws_s3_bucket.static_website.bucket
  key          = each.value
  source       = "website/${each.value}"
  content_type = lookup(var.mime_types, split(".", each.value)[1], "application/octet-stream")
}

resource "aws_s3_object" "img_files_upload" {
  for_each = fileset("website/img", "*")

  bucket       = aws_s3_bucket.static_website.bucket
  key          = "img/${each.value}"
  source       = "website/img/${each.value}"
  content_type = lookup(var.mime_types, split(".", each.value)[1], "application/octet-stream")
}
