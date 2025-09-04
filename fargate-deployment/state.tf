terraform {
  backend "s3" {
    bucket         = "terraform-bucket-csv-distro-application"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "csv-distro-application"
  }
}