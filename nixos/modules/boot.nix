{ config, pkgs, ... }:

{
  boot.loader = {
    # Настройка GRUB
    grub = {
      enable = true;
      efiSupport = true;
      # "nodev" используется для EFI систем
      device = "nodev";
      # Автоматический поиск других ОС (Windows, другие дистрибутивы)
      useOSProber = true;
      
      # Дополнительные полезные настройки (опционально):
      # configurationLimit = 10; # Ограничить количество старых записей в меню
      # theme = pkgs.nixos-grub-themes.stylish; # Можно установить тему
    };

    # Разрешаем изменять переменные EFI (необходимо для записи загрузчика в NVRAM)
    efi.canTouchEfiVariables = true;
    
    # Путь к монтированию EFI раздела (по умолчанию /boot)
    efi.efiSysMountPoint = "/boot"; 
  };
}