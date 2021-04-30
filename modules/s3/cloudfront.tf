resource "aws_cloudfront_origin_access_identity" "s3_origin_identity" {
    comment = "Origin access identity"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
    depends_on = [ aws_cloudfront_origin_access_identity.s3_origin_identity ]
    origin {
        domain_name = aws_s3_bucket.main.bucket_regional_domain_name
        origin_id   = aws_s3_bucket.main.id

        s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.s3_origin_identity.cloudfront_access_identity_path
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.main.id

        forwarded_values {
        query_string = false

        cookies {
            forward = "none"
        }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    price_class = "PriceClass_200"

    restrictions {
        geo_restriction {
        restriction_type = "none"
        }
    }

    tags = {
        Environment = var.env
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}