variable "image_name" {
  type    = string
  default = "nginx:latest"
}

variable "container_name" {
  type    = string
  default = "nginx_container"
}

variable "host_port" {
  type    = number
  default = 8080
}

variable "container_port" {
  type    = number
  default = 80
}

