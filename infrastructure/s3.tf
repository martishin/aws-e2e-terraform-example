# 1. Add the S3 bucket resource
resource "aws_s3_bucket" "file_upload_bucket" {
  bucket = "martishin-my-file-upload-bucket"

  tags = {
    Name = "file-upload-bucket"
  }
}

# 2. Add Bucket Policy to Allow Public Read Access
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "file_upload_bucket_policy" {
  bucket = aws_s3_bucket.file_upload_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ],
        Resource = [
          "${aws_s3_bucket.file_upload_bucket.arn}/*"
        ]
      }
    ]
  })
}

# 3. Define IAM Role and Policies for S3 Access
resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "s3_access_policy"
  role = aws_iam_role.s3_access_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutBucketPolicy",
        ],
        Resource = [
          aws_s3_bucket.file_upload_bucket.arn,
          "${aws_s3_bucket.file_upload_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "s3_access_instance_profile" {
  name = "s3_access_instance_profile"
  role = aws_iam_role.s3_access_role.name
}
