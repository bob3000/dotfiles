function aws_route53_domain_requests --description "show domain request for a domain"
    aws --region us-east-1 route53domains list-operations --query "Operations[?DomainName==`$argv[1]`]"
end
