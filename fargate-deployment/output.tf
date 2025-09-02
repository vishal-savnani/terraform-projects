
output "ecr" {
  value = data.aws_ecr_repository.ecr_repo
}
output "subnets" {
  value = data.aws_subnets.default_vpc_subnets.ids
}
output "image" {
  value = data.aws_ecr_image.image.id
}
output "domain" {
  value = aws_lb.ALB.dns_name
}