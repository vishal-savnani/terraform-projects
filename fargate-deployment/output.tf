
output "ecr" {
  value = data.aws_ecr_repository.ecr_repo.repository_url
}
output "subnets" {
  value = data.aws_subnets.default_vpc_subnets

}