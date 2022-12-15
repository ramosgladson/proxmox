resource "proxmox_vm_qemu" "newsrv_1" {
    name = "newsrv_1"
    desc = "Ubuntu Server"
    vmid = "401"
    target_node = "pve1"

    agent = 0

    clone = "ubuntu-cloud"
    full_clone = true
    cores = 1
    sockets = 1
    cpu = "host"
    memory = 1024

    network {
        bridge = "vmbr0"
        model = "virtio"
    }
    
    disk {
        storage = "local-lvm"
        type = "virtio"
        size = "32G"
    }
    
    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.0.21/24,gw=192.168.0.1"
    nameserver = "8.8.8.8"
    ciuser = "user"
    sshkeys = <<EOF
    ssh-rsa ldsfkjlfkjalfkjslakdgjlsakgj[...]
    EOF
}

