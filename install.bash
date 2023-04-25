#!/usr/bin/env bash

set -xeuo pipefail

dev=/dev/vda

sudo sgdisk --zap-all "$dev"

sudo sgdisk --set-alignment=1 --new=2:24K:+1000K --typecode=2:EF02 "$dev"
sudo sgdisk --new=1:0:0 --typecode=1:8300 "$dev"

sudo partprobe "$dev"
udevadm settle

sudo mkfs.ext4 -F -L nixos-root "${dev}1"
sudo mount -o noatime "${dev}1" /mnt

sudo nixos-install --flake .#nixos --no-root-passwd --show-trace

# vim: ft=bash:ts=2:sw=2:et
