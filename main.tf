terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

# Настройки подключения к твоему облаку
provider "yandex" {
  cloud_id  = "b1glqcj178sd03pbhjp4"
  folder_id = "b1gpmjvabfqc88m9u7nj"
  zone      = "ru-central1-d"
}

# Описание автоматического создания виртуальной машины
resource "yandex_compute_instance" "vm-redmine-2" {
  name        = "redmine-server-automated"
  platform_id = "standard-v3" # <--- Исправленная платформа процессора (Intel Ice Lake)

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd879gb88170to70d38a" # Образ Ubuntu 24.04
    }
  }

  network_interface {
    subnet_id = "fl8a6gibcosq06mrv5cg" # Твоя подсеть
    nat       = true                   # Включить публичный IP
  }

  metadata = {
    # Автоматическая прокидка твоего SSH-ключа
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}