data "digitalocean_ssh_key" "my_ssh" {
  name = var.ssh_name
}

resource "digitalocean_droplet" "web" {
  count    = 2
  image    = var.droplet_image
  name     = "hexlet-devops-project-web-${count.index + 1}"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.my_ssh.id]
}

resource "digitalocean_certificate" "cert" {
  name    = "le-terraform-example"
  type    = "lets_encrypt"
  domains = [var.domain]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "hexlet-devops-project-lb"
  region = var.region

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = var.app_port
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = var.app_port
    target_protocol = "http"
  }

  healthcheck {
    port     = var.app_port
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.web.*.id
}

resource "digitalocean_domain" "default" {
  name       = var.domain
  ip_address = digitalocean_loadbalancer.public.ip
}

resource "digitalocean_database_cluster" "db" {
  name       = "postgres-cluster-project3"
  engine     = var.db_engine
  version    = var.db_version
  size       = var.db_size
  region     = var.region
  node_count = 1
}

resource "digitalocean_database_firewall" "trusted_web_sources" {
  cluster_id = digitalocean_database_cluster.db.id

  dynamic "rule" {
    for_each = digitalocean_droplet.web
    content {
      type  = "droplet"
      value = rule.value["id"]
    }
  }
}

resource "datadog_monitor" "app_monitor" {
  name    = "http check {{ host.name }}"
  type    = "service check"
  message = " @jekson87@me.com"

  query = "\"http.can_connect\".over(\"*\").by(\"host\",\"instance\",\"url\").last(2).count_by_status()"

  monitor_thresholds {
    warning  = 1
    ok       = 1
    critical = 1
  }

  notify_no_data    = false
  renotify_interval = 0
  notify_audit      = false
  timeout_h         = 0
  no_data_timeframe = 2
  new_group_delay   = 60
}