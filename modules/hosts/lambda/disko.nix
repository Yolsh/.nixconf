{
    flake.diskoConfigurations.Lambda = {
        fileSystems."/nix".neededForBoot = true;

        disko.devices = {
            disk.main = {
                device = "/dev/disk/by-id/mmc-MMC64G_0x00362da9";
                type = "disk";
                content = {
                    type = "gpt";
                    partitions = {
                        boot = {
                            name = "boot";
                            size = "1M";
                            type = "EF02";
                        };
                        esp = {
                            name = "ESP";
                            size = "1G";
                            type = "EF00";
                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                            };
                        };
                        swap = {
                            size = "4G";
                            content = {
                                type = "swap";
                                resumeDevice = true;
                            };
                        };
                        root = {
                            name = "root";
                            size = "100%";
                            content = {
                                type = "btrfs";
                                extraArgs = ["-f"];
                                subvolumes = {
                                    "/persistent" = {
                                        mountOptions = ["subvol=persist" "noatime"];
                                        mountpoint = "/persistent";
                                    };
                                    "/nix" = {
                                        mountOptions = ["subvol=nix" "noatime"];
                                        mountpoint = "/nix";
                                    };
                                };
                            };
                        };
                    };
                };
            };
            nodev = {
                "/" = {
                    fsType = "tmpfs";
                    mountOptions = [
                        "size=25%"
                        "mode=755"
                    ];
                };
            };
        };
    };
}