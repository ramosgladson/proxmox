# Proxmox
> Proxmox is a hypervisor

## How to install proxmox

1. Download iso image and make a USB flash drive

```
$ wget https://enterprise.proxmox.com/iso/proxmox-ve_7.3-1.iso
$ sudo mkfs -t vfat /dev/sda1                                            | Keep in mind /dev/sda1 was my partition
$ sudo dd if=/home/ramos/Download/proxmox-ve_7.3-1.iso of=/dev/sda       | wait till finish, can take a couple of minutes
$ sudo eject /dev/sda1                                                   | don’t forget to use your partition, ok?
```
2. Follow steps on boot loader
3. More details on this [tutorial][tutorial]

## Disable root account
> [Diable root][disable-root]

```
# apt update -y && apt upgrade -y
# apt install sudo
# adduser newuser
# usermod -aG sudo newuser
```
Disable root at proxmox web interface, so, hands on:
1. Select datacenter at left menu
2. Permissions
3. Users
4. add
Type your new user account you have add at cli, and make sure the enable box is checked.
Get back to Permissions menu, as the step 2
5. Permission
6. User permissions
Path: /
User: newuseraccount
Role: Administrator
Propagate: |x| check this box
7. User
Select the new user and click on password botton to reset password and make sure it's gonna work
Logout and login with your new user.
Select datacenter at right menu again, permissions and users.
Select root and click on edit botton.
uncheck enabled box
Disable root at cli:
At the terminal, login with new user and disable root account password
```
# su newuser
# sudo passwd -l root
```

## Making a image template
>Using cloud-images from ubuntu

1. SSH your proxmox
ssh user@proxmox

```
# wget http://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img (there are other options at http://cloud-images.ubuntu.com/)
# mv jammy-server-cloudimg-amd64.img ubuntu-22.04.qcow2
# qemu-img resize ubuntu-22.04.qcow2 32G
# qm create 8000 --memory 1024 --core 1 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
# qm importdisk 8000 ubuntu-22.04.qcow2 local-lvm
# qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
# qm set 8000 --ide2 local-lvm:cloudinit
# qm set 8000 --boot c --bootdisk scsi0
# qm set 8000 --serial0 socket --vga serial0
```

## Automating with terraform
>[telmate/proxmox][telmate]

<!-- Markdown Links -->
[tutorial]: https://www.youtube.com/watch?v=BBne0HGLld4&list=PL-SkhJm0NYpn6Nrx2IhiSZcbetT2JpZJ4
[disable-root]: https://www.youtube.com/watch?v=MXtnTiZEyro
[telmate]: https://www.youtube.com/watch?v=dvyeoDBUtsU