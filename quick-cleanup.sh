#!/bin/bash
# Быстрая безопасная очистка ~15 ГБ

echo "🧹 Быстрая очистка Mac..."

# JetBrains кэш (инсталляторы и бэкапы)
echo "→ JetBrains Toolbox кэш..."
rm -rf ~/Library/Caches/JetBrains/Toolbox/download/*
rm -rf ~/Library/Caches/JetBrains/Toolbox/backup/*

# Браузеры
echo "→ Кэши браузеров..."
rm -rf ~/Library/Caches/Arc/*
rm -rf ~/Library/Caches/zen/*
rm -rf ~/Library/Caches/Google/*

# Homebrew
echo "→ Homebrew..."
brew cleanup -s 2>/dev/null || true

# Python
echo "→ Python кэш..."
find ~/Dev -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
find ~/Dev -name '*.pyc' -delete 2>/dev/null || true
rm -rf ~/Library/Caches/pip/*

# Node
echo "→ Node кэш..."
rm -rf ~/Library/Caches/node-gyp/*

# Корзина и логи
echo "→ Корзина и логи..."
rm -rf ~/.Trash/*
rm -rf ~/Library/Logs/*

echo ""
echo "✅ Готово!"
echo "📊 Свободно места:"
df -h / | tail -1
