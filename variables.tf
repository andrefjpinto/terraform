variable "env" {
  default = "dev"
  description = "The environment where the application will be deployed"
}

variable "name" {
  default = "iem"
  description = "The name of the application"
}

variable "repo" {
  default     = "https://github.com/andrefjpinto/terraform"
  description = "The url of the repository in github"
}