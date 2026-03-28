{
  description = "My system configuration";

  inputs = {
    # Обновлено до 25.11
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      # Обновлено до 25.11
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      # Обновлено до 25.11
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    homeStateVersion = "25.11"; # Обновлено
    user = "slava"; # Обновлено имя пользователя

    # Список хостов сокращен до одного NixOwO
    hosts = [
      { hostname = "NixOwO"; stateVersion = "25.11"; }
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };
      modules = [
        # Обратите внимание: теперь путь будет ./hosts/NixOwO/configuration.nix
        ./hosts/${hostname}/configuration.nix
      ];
    };
  in {
    # Генерация конфигурации NixOS
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    # Конфигурация Home Manager (Standalone)
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
      };
      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}