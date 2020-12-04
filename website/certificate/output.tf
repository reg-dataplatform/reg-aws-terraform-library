output "certificate_arn"         {value = aws_acm_certificate.this.arn}
output "certificate_id"          {value = aws_acm_certificate.this.id}
output "certificate_domain_name" {value = aws_acm_certificate.this.domain_name}
output "route53_record_zone_id"  {value = values(aws_route53_record.this)[*].zone_id}
output "route53_record_name"     {value = values(aws_route53_record.this)[*].name}
output "route53_record_type"     {value = values(aws_route53_record.this)[*].type}