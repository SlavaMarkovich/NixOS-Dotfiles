{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
     git
    # gcc
    # kdenlive
    # jetbrains.pycharm-professional
    # jre8
    # qemu
    # quickemu
  ];

}
