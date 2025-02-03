variable "mysql_username" {
  description = "DB Admin username"
  type        = string
}

variable "mysql_password" {
  description = "DB Admin password"
  type        = string
  #sensitive   = true
}
