output "ip_addresses" {
  value = digitalocean_droplet.web.*.ipv4_address
}