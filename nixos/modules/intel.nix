{ config, pkgs, ... }:

{
  # Включаем аппаратную поддержку графики
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Важно для Steam, Wine и старых игр

    extraPackages = with pkgs; [
      # Драйвер i965 — единственный рабочий VAAPI драйвер для Bay Trail (Gen7)
      intel-vaapi-driver
      # Поддержка ускорения в приложениях, использующих старый стандарт VDPAU
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    # Указываем системе использовать i965 для декодирования видео
    LIBVA_DRIVER_NAME = "i965";
    
    # Рекомендуется для Bay Trail: современный драйвер 'crocus' вместо старого 'i965'
    # Он дает лучшую производительность и стабильность в 3D (OpenGL)
    MESA_LOADER_DRIVER_OVERRIDE = "crocus";
  };

  # Опционально: полезные утилиты для мониторинга в системных пакетах
  environment.systemPackages = with pkgs; [
    intel-gpu-tools # Команда 'intel_gpu_top' покажет реальную нагрузку на видеоядро
    libva-utils # Инструмент для проверки работоспособности (vainfo)
  ];
}
