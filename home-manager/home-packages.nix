{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically (no)

    # Desktop apps
    telegram-desktop
    vscode
    firefox
    obsidian
    discord
    
    # CLI utils
    btop
    fastfetch

    # Games
    prismlauncher
  ];

}

