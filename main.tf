terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = "b1glqcj178sd03pbhjp4"
  folder_id = "b1gpmjvabfqc88m9u7nj"
  zone      = "ru-central1-d"
}

resource "yandex_compute_instance" "vm-redmine-2" {
  name        = "redmine-server-automated"
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd879gb88170to70d38a"
    }
  }

  network_interface {
    subnet_id = "fl8a6gibcosq06mrv5cg"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}