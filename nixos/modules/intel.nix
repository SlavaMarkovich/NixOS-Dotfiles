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

  # Опционально: полезные утилиты для мониторинга в системных пакетах
  environment.systemPackages = with pkgs; [
    intel-gpu-tools # Команда 'intel_gpu_top' покажет реальную нагрузку на видеоядро
    libva-utils # Инструмент для проверки работоспособности (vainfo)
  ];
}
