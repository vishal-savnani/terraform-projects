variable "region" {
  default = "eu-west-2"
}

variable "ecr_repo" {
  default = "vishalsavnani/flask-web"
}

variable "app-name" {
  default = "csv-distro-application"
}
variable "container-port" {
  default = 5000

}

variable "host-port" {
  default = 5000
}
variable "path-check" {
  default = "/"

}
variable "desired_count" {
  default = 2
}

variable "mem" {
  default = "512"
}

variable "cpu" {
  default = "256"
}
