resource "google_compute_instance" "default" {
  name         = "gb-iac-hw4-ansible-host"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }
    metadata = {
	  ssh-keys = "voy:${file(id_rsa.pub)}"
	}  
    metadata_startup_script = "" 

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}

resource "google_compute_instance" "default1" {
  name         = "gb-iac-hw4-test-host1"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }
    metadata = {
	  ssh-keys = "voy:${file(id_rsa.pub)}"
	}  
    metadata_startup_script = "" 

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}
resource "google_compute_instance" "default2" {
  name         = "gb-iac-hw4-test-host2"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }
    metadata = {
	  ssh-keys = "voy:${file(id_rsa.pub)}"
	}  
    metadata_startup_script = "" 

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-gitlab"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
