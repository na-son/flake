{ config, pkgs, lib, modulesPath, ... }:

let
  encryptedDeviceLabel = "encrypt";
  encryptedDevice = "/dev/nvme0n1p2";
  efiDevice = "/dev/nvme0n1p1";
  makeMounts = import ./../functions/make_mounts.nix;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    boot.kernel.sysctl = {
      "dev.i915.perf_stream_paranoid" = 0;
    };
    boot.loader.efi.efiSysMountPoint = "/boot";
    fileSystems = makeMounts {
      inherit encryptedDevice encryptedDeviceLabel efiDeviceLabel;
    };

    networking.hostName = "nomad";
    networking.domain = "hoverbear.home";
  };
}

