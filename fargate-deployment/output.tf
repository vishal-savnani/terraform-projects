output "aws-subnet" {
  value = data.aws_subnet.default_vpc_subnet
}

output "ecr" {
  value = data.aws_ecr_repository.ecr_repo.repository_url
}