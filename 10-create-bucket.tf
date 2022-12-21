# Create a bucket
resource "aws_s3_bucket" "whyarebucketnamesalwaystaken-bucket" {
  bucket = "whyarebucketnamesalwaystaken-bucket"
  tags = {
    Name        = "DEV-BUCKET"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.whyarebucketnamesalwaystaken-bucket.id
  acl    = "private"
}

# Upload an object to the bucket from current directory
  resource "aws_s3_object" "object1" {
  for_each = fileset("s3-files/", "*")
  bucket = aws_s3_bucket.whyarebucketnamesalwaystaken-bucket.id
  key = each.value
  source = "s3-files/${each.value}"
  etag = filemd5("s3-files/${each.value}")
}