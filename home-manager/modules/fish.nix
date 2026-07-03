{ config, pkgs, ... }:

{
  # Увімкнення оболонки Fish та інтеграції зі Starship
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""

      # Показуємо fastfetch з обраним конфігом замість стандартного привітання
      if status is-interactive
        fastfetch --config "${pkgs.fastfetch}/share/fastfetch/presets/examples/32.jsonc"
      end
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
        [│](overlay0)$nodejs$rust$python$golang$lua$package
        [╰─](overlay0)$character'';

      right_format = "$cmd_duration$time";

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
