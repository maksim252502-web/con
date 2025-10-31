#!/bin/bash

echo "🔧 Шаг 1: Установка Docker..."
sudo apt update && sudo apt install -y docker.io

echo "🚀 Шаг 2: Запуск демона Docker на 3 секунды..."
sudo dockerd &
DOCKER_PID=$!
sleep 3
kill $DOCKER_PID
echo "⛔ Демон Docker остановлен."

echo "📦 Шаг 3: Запуск контейнера Arch Linux и установка пакетов..."
docker run --network=host -it archlinux bash -c "
  echo '🔄 Обновление системы...'
  pacman -Syu --noconfirm

  echo '📥 Установка необходимых пакетов...'
  pacman -S --noconfirm wget curl gmp boost nano base-devel gcc glibc

  echo '⬇️ Загрузка rieMiner...'
  wget https://riecoin.xyz/rieMiner/Download/Deb64AVX2 -O rieminer.deb

  echo '📦 Подготовка rieMiner...'
  mv rieminer.deb rieminer2
  chmod +x rieminer2

  echo '📝 Создание конфигурации rieMiner.conf...'
  echo -e 'Mode = Pool\nHost = ric.suprnova.cc\nPort = 5000\nUsername = lomalo.lomalo\nPassword = pass\nThreads = 2' > rieMiner.conf

  echo '✅ Установка завершена. Запусти ./rieminer2 для майнинга.'
"
