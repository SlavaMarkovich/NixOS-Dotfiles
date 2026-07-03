{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically (no)

    # Desktop apps
    telegram-desktop
    vscode
    obsidian
    discord
    
    # CLI utils
    btop
    fastfetch
    curl
    wget

    # Games
    prismlauncher
  ];

}

