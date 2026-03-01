#!/bin/bash
# Оптимизация MacBook Air M1 - быстрая очистка

echo "🧹 Очистка macOS..."

# Очистка кэшей
echo "→ Очистка кэшей пользователя..."
rm -rf ~/Library/Caches/* 2>/dev/null

# Очистка логов
echo "→ Очистка старых логов..."
rm -rf ~/Library/Logs/* 2>/dev/null

# Очистка корзины
echo "→ Очистка корзины..."
rm -rf ~/.Trash/* 2>/dev/null

# Очистка кэша DNS
echo "→ Сброс DNS кэша..."
sudo dscacheutil -flushcache 2>/dev/null
sudo killall -HUP mDNSResponder 2>/dev/null

# Очистка swap (через перезапуск memory pressure)
echo "→ Проверка памяти..."
memory_pressure

echo ""
echo "✅ Очистка завершена!"
echo "📊 Статистика диска:"
df -h / | tail -1
