resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"
  ignore_public_acls = false

  versioning {
    enabled = false
  }
  
  tags = {
    Name = "My Test Bucket"
  }
}

resource "aws_s3_bucket_policy" "insecure_policy" {
  bucket = aws_s3_bucket.insecure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = join("", [ "arn:aws:s3:::", aws_s3_bucket.insecure_bucket.id, "/*" ]),
        Principal = "*",
      },
    ],
  })
}

resource "aws_s3_bucket_public_access_block" "insecure_public_access_block" {
    bucket = aws_s3_bucket.insecure_bucket.id

    block_public_acls = false

    restrict_public_buckets = false
}
