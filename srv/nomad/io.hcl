job "io" {
  datacenters = ["dc1"]
  type = "service"
  group "io" {
    count = 1
    service {
      name = "io"
      provider = "nomad"
    }
    volume "io" {
      type      = "host"
      read_only = false
      source    = "io"
    }
    task "io" {
      driver = "docker"
      config {
        image = "agentio/io:latest"
        network_mode = "host"
        force_pull = true
      }
      volume_mount {
        volume = "io"
        destination = "/io"
        read_only = false
      }
    }
  }
}

