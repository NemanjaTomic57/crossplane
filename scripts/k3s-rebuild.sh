#!/bin/bash -xeu

for i in {1..6}
do
  sudo virsh destroy rocky10-k3s-${i}
done

for i in {1..6}
do
  sudo virsh undefine rocky10-k3s-${i}
done

sudo rm /var/lib/libvirt/images/rocky10-k3s-*

for i in {1..6};
do
  sudo virt-clone \
    --original rocky10 \
    --name rocky10-k3s-${i} \
    --file /var/lib/libvirt/images/rocky10-k3s-${i}.qcow2
done

for i in {1..6}
do 
  sudo virsh start rocky10-k3s-${i}
done

sleep 60

for i in {1..6}; do sudo virsh domifaddr rocky10-k3s-${i}; done
