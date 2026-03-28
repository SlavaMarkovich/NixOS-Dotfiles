{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    spotify
    google-chrome
    telegram-desktop
    vscodium

    # CLI utils
    btop
    fastfetch
  ];

}

