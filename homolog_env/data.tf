data "aws_acm_certificate" "issued" {
  domain   = "*.timsmart.com.br"
  statuses = ["ISSUED"]
}