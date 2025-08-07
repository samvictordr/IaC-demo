output "container_id" {
  value = docker_container.nginx.id
}

output "host_port" {
  value = var.host_port
}
