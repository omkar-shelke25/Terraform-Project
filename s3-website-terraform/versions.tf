resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.static_website.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
