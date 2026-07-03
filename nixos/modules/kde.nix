{ config, pkgs, ... }:

{
  # ──────────────────────────────────────────────
  #  Display Manager & Desktop Environment
  # ──────────────────────────────────────────────
  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      plasma-login-manager.enable = true;
    };
  };

  # ──────────────────────────────────────────────
  #  KDE Connect (телефон ↔ ПК)
  # ──────────────────────────────────────────────
  programs.kdeconnect.enable = true;

  # ──────────────────────────────────────────────
  #  Системные пакеты
  # ──────────────────────────────────────────────
  environment.systemPackages = with pkgs; [

    # --- Управление системой ---
    kdePackages.discover              # менеджер приложений
    kdePackages.sddm-kcm              # настройки SDDM в Plasma
    kdePackages.plasma-systemmonitor  # системный монитор
    kdePackages.ksystemlog            # просмотр системных логов
    kdePackages.partitionmanager      # управление дисками

    # --- Утилиты ---
    kdePackages.kcalc                 # калькулятор
    kdePackages.kcharselect           # выбор символов Unicode
    kdePackages.ktimer                # таймер
    kdePackages.kfind                 # поиск файлов
    kdePackages.filelight             # анализатор дискового пространства
    kdePackages.isoimagewriter        # запись ISO на USB

    # --- Интеграция браузера ---
    kdePackages.plasma-browser-integration

    # --- Работа с архивами ---
    kdePackages.ark

    # --- Изображения ---
    kdePackages.gwenview              # просмотр изображений
    kdePackages.spectacle             # скриншоты

    # --- Текст и офис ---
    kdePackages.kate                  # текстовый редактор

    # --- Сеть ---
    kdePackages.kget                  # менеджер загрузок

    # --- Настройка системы ---
    kdePackages.plasma-vault          # шифрованные хранилища
    kdePackages.kscreen               # управление мониторами

  ];

  # ──────────────────────────────────────────────
  #  Шрифты
  # ──────────────────────────────────────────────
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      
    ];
    fontconfig.defaultFonts = {
      serif      = [ "Noto Serif" ];
      sansSerif  = [ "Noto Sans" ];
      monospace  = [ "Noto Sans Mono" ];
      emoji      = [ "Noto Color Emoji" ];
    };
  };

  # ──────────────────────────────────────────────
  #  GTK-интеграция (тема Breeze для GTK-приложений)
  # ──────────────────────────────────────────────
  programs.dconf.enable = true;       # нужен для GTK-настроек через KDE

  qt = {
    enable          = true;
    platformTheme   = "kde";
    style           = "breeze";
  };
}
