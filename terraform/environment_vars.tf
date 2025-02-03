variable "mysql_username" {
  description = "DB Admin username"
  type        = string
}

variable "mysql_password" {
  description = "DB Admin password"
  type        = string
  sensitive   = true
}

output "show_mysql_username" {
  value = var.mysql_username
}

output "show_mysql_password" {
  value = var.mysql_password
}