variable "region" {
  type = string
  default = "us-west-2"
}

variable "vpc" {
  type = map(string)
  default = {
    cidr = "172.16.0.0/16"
  }
}

variable "azs" {
  type = map(string)
  default = {
    a = "us-west-2a"
    b = "us-west-2b"
  }
}

variable "web_a" {
  type = map(string)
  default = {
    cidr = "172.16.0.0/20"
  }
}

variable "app_a" {
  type = map(string)
  default = {
    cidr = "172.16.16.0/20"
  }
}

variable "db_a" {
  type = map(string)
  default = {
    cidr = "172.16.32.0/20"
  }
}

variable "web_b" {
  type = map(string)
  default = {
    cidr = "172.16.48.0/20"
  }
}

variable "app_b" {
  type = map(string)
  default = {
    cidr = "172.16.64.0/20"
  }
}

variable "db_b" {
  type = map(string)
  default = {
    cidr = "172.16.80.0/20"
  }
}
