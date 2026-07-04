{ config, pkgs, ... }:

{
  # Увімкнення оболонки Fish та інтеграції зі Starship
  programs.fish = {
    enable = true;

    # Скорочення (abbreviations): fish розгортає їх прямо у рядку
    # вводу до повного тексту команди, тож в history лишається
    # читабельна команда, а не незрозумілий alias.
    # Постав/забери те, що реально використовуєш 🙂
    shellAbbrs = {
      ".." = "cd ..";
      "..." = "cd ../..";
      gs = "git status -sb";
      gc = "git commit -m";
      gp = "git push";
      gl = "git pull";
      nrs = "sudo nixos-rebuild switch --flake .";
      nfu = "nix flake update";
      hms = "home-manager switch --flake .";
    };

    # Пара плагінів прямо з nixpkgs (fisher не потрібен):
    # - autopair сам закриває дужки/лапки;
    # - fzf-fish додає нечіткий пошук по history (Ctrl+R) і файлах
    #   (Ctrl+T). Йому потрібен встановлений пакет fzf, наприклад
    #   через home.packages = [ pkgs.fzf ];
    plugins = [
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];

    interactiveShellInit = ''
      set -g fish_greeting ""

      # home-manager сам загортає interactiveShellInit у
      # `status --is-interactive`, тому додаткова перевірка тут
      # була зайвою — просто викликаємо fastfetch напряму.
      #
      # ⚠️ "32.jsonc" — це порядковий номер файлу з прикладів
      # fastfetch, а не стабільний ідентифікатор: після оновлення
      # пакета набір прикладів може змінитись, і шлях перестане
      # існувати. Якщо колись побачиш помилку на кшталт
      # "config file not found" — згенеруй свій конфіг
      # (fastfetch --gen-config), поклади його як
      # xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch.jsonc;
      # і посилайся вже на нього, а не на приклад із /nix/store.
      fastfetch --config "${pkgs.fastfetch}/share/fastfetch/presets/examples/32.jsonc"
    '';
  };

  # Налаштування Starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      palette = "catppuccin_mocha";
      add_newline = true;

      # Багаторядковий, інформативний prompt
      format = ''
        [╭─](overlay0)$os$username$hostname$directory$git_branch$git_status$git_metrics
        [│](overlay0)$nix_shell$nodejs$rust$python$golang$lua$package
        [╰─](overlay0)$status$character'';

      right_format = "$battery$cmd_duration$time";

      character = {
        success_symbol = "[❯](bold pink)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      os = {
        disabled = false;
        style = "bold text";
        symbols = {
          NixOS = "❄️ ";
          Linux = " ";
          Windows = " ";
          Macos = " ";
        };
      };

      username = {
        style_user = "bold sapphire";
        style_root = "bold red";
        format = "[$user]($style)";
        show_always = false;
      };

      hostname = {
        ssh_only = true;
        style = "bold peach";
        format = "[@$hostname]($style) ";
      };

      directory = {
        style = "bold lavender";
        truncation_length = 4;
        truncate_to_repo = true;
        home_symbol = "~";
        read_only = " 󰌾";
      };

      git_branch = {
        symbol = " ";
        style = "bold mauve";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold maroon";
        format = "([$all_status$ahead_behind]($style)) ";
      };

      git_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
      };

      # Показує, коли ти сидиш всередині nix-shell / nix develop —
      # дуже рятує пам'ять саме на NixOS.
      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };

      nodejs = {
        symbol = " ";
        style = "bold green";
        format = "[$symbol($version)]($style) ";
      };

      rust = {
        symbol = " ";
        style = "bold peach";
        format = "[$symbol($version)]($style) ";
      };

      python = {
        symbol = " ";
        style = "bold yellow";
        format = "[$symbol($version)]($style) ";
      };

      golang = {
        symbol = " ";
        style = "bold sky";
        format = "[$symbol($version)]($style) ";
      };

      lua = {
        symbol = " ";
        style = "bold blue";
        format = "[$symbol($version)]($style) ";
      };

      package = {
        symbol = "󰏗 ";
        style = "bold teal";
        format = "[$symbol$version]($style) ";
      };

      # За замовчуванням модуль ховається, якщо команда завершилась
      # успішно (success_symbol лишається порожнім) — показується
      # тільки код помилки, коли щось пішло не так.
      status = {
        disabled = false;
        symbol = "✖ ";
        style = "bold red";
        format = "[$symbol$status]($style) ";
      };

      cmd_duration = {
        min_time = 500;
        style = "bold overlay2";
        format = "[$duration]($style) ";
      };

      time = {
        disabled = false;
        style = "bold subtext0";
        time_format = "%H:%M";
        format = "[$time]($style)";
      };

      # Заряд батареї — доречно на ноутбуці (Lenovo B50-30).
      battery = {
        full_symbol = "🔋";
        charging_symbol = "🔌";
        discharging_symbol = "⚡";
        display = [
          { threshold = 15; style = "bold red"; }
          { threshold = 50; style = "bold yellow"; }
        ];
      };

      # Визначення кольорової палітри Catppuccin Mocha
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
