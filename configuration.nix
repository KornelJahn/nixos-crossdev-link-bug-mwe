{ self, config, pkgs, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  environment.systemPackages = [ self.packages.x86_64-linux.default ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos-root";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  swapDevices = [ ];

  networking.hostName = "nixos";
  networking.useDHCP = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  users.mutableUsers = false;
  users.users.nixos = {
    isNormalUser = true;
    password = "nixos";
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "22.11";
}
