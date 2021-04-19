resource "aws_s3_bucket" "main" {
    bucket = var.s3_bucketname
    acl    = "public-read"

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

resource "aws_s3_bucket_policy" "main" {
    depends_on = [ aws_s3_bucket.main ]
    bucket = aws_s3_bucket.main.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Sid       = "PublicReadGetObject"
            Effect    = "Allow"
            Principal = "*"
            Action    = "s3:GetObject"
            Resource = [
            "${aws_s3_bucket.main.arn}/*"
            ]
        }
        ]
    })
}