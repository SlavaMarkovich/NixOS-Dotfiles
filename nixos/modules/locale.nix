{ config, pkgs, ... }:

{
  # Настройка часового пояса
  time.timeZone = "Europe/Kyiv";

  # Настройка локализации системы
  i18n.defaultLocale = "uk_UA.UTF-8";

  # Дополнительные параметры локали (форматы дат, валют и т.д.)
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };
}
