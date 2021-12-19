// Токен DO и путь к приватному ключу, будут передаваться через CLI
variable "do_token" {
  description = "Please Enter DO Token"
  type        = string
  sensitive   = true
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "ssh_name" {
  type        = string
  default     = "Mac Pro"
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "droplet_image" {
  type    = string
  default = "docker-20-04"
}

variable "droplet_size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "db_engine" {
  type    = string
  default = "pg"
}

variable "db_version" {
  type    = string
  default = "11"
}

variable "db_size" {
  type    = string
  default = "db-s-1vcpu-1gb"
}

variable "domain" {
  type    = string
  default = "contract-management.club"
}