# ❄️ NixOwO — My Personal NixOS Flake (Description from Google Gemini BTW)

Добро пожаловать в мой уголок декларативного хаоса. Это репозиторий с конфигами для моей основной машины. Сделано Славой для Славы (но если ты не Слава — используй на свой страх и риск).

## 🚀 Процесс установки (Fresh Install)

Инструкция для запуска с LiveUSB. Предполагается, что диски уже размечены и примонтированы в `/mnt`.

### 1. Подготовка конфига

Сначала забираем репозиторий и подкидываем конфиг железа, который сгенерировал установщик.

```bash
# Переходим в папку с будущим конфигом
mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos

# Клонируем репо (в текущую директорию)
git clone https://github.com/SlavaMarkovich/NixOS-Dotfiles.git .

# Копируем сгенерированный железом конфиг в папку хоста
cp /etc/nixos/hardware-configuration.nix ./hosts/NixOwO/

# Добавляем всё в git, иначе Flakes их не "увидит"
git add .

```

### 2. Магия установки

Запускаем сборку системы и не забываем про пароль, чтобы не остаться "снаружи" после ребута.

```bash
# Установка системы из Flake
nixos-install --flake .#NixOwO --root /mnt

# Установка пароля для пользователя slava
nixos-enter --root /mnt -c "passwd slava"

```

### 3. Финальные штрихи (после перезагрузки)

Заходим в новую систему, логинимся и подтягиваем настройки пользователя через Home Manager.

```bash
# Заходим в папку с конфигами
cd /etc/nixos

# Исправляем ругань гита на права доступа
git config --global --add safe.directory /etc/nixos/NixOS-Dotfiles

# Разворачиваем Home Manager
nix run home-manager -- switch --flake .#slava

```

---

## 🛠 Полезные команды на будущее

* `sudo nixos-rebuild switch --flake .` — применить изменения системы.
* `home-manager switch --flake .` — применить изменения юзера.
* `nix flake update` — обновить все зависимости (input-ы).
* `sudo chown -R slava:users /etc/nixos/NixOS-Dotfiles` — вернуть права на конфигурацию

**P.S.** Если что-то сломалось — вини во всем системд. Удачи! 🍀
