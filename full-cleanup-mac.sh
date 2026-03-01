#!/bin/bash
# Полная очистка MacBook для Python разработчика
# ⚠️ Внимательно читай перед запуском!

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo "🧹 ПОЛНАЯ ОЧИСТКА MACBOOK AIR M1"
echo "======================================"
echo ""

# Показываем что будет удалено
echo -e "${YELLOW}📊 ТЕКУЩЕЕ СОСТОЯНИЕ:${NC}"
echo "Кэши: $(du -sh ~/Library/Caches 2>/dev/null | cut -f1)"
echo "Docker: $(du -sh ~/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw 2>/dev/null | cut -f1)"
echo "Корзина: $(du -sh ~/.Trash 2>/dev/null | cut -f1)"
echo ""

# 1. JetBrains Cache - самое большое
echo -e "${YELLOW}📦 JetBrains Toolbox Cache (15 ГБ)${NC}"
read -p "Удалить кэш JetBrains? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ~/Library/Caches/JetBrains/Toolbox/download/*
    rm -rf ~/Library/Caches/JetBrains/Toolbox/backup/*
    echo -e "${GREEN}✅ JetBrains кэш очищен${NC}"
fi

# 2. Docker - сбросить до минимума
echo ""
echo -e "${YELLOW}🐳 Docker (может быть 10+ ГБ)${NC}"
echo "Варианты:"
echo "  1) Сбросить весь Docker (удалить все контейнеры, образы)"
echo "  2) Только сжать диск (сохранить данные)"
echo "  3) Пропустить"
read -p "Выбор (1/2/3): " docker_choice

case $docker_choice in
    1)
        echo "Останавливаем Docker..."
        osascript -e 'quit app "Docker"' 2>/dev/null || true
        sleep 3
        rm -f ~/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw
        echo -e "${GREEN}✅ Docker полностью сброшен${NC}"
        ;;
    2)
        echo "Для сжатия Docker нужно сделать в приложении:"
        echo "Docker Desktop → Settings → Resources → Disk image size → Compact"
        ;;
    3)
        echo "Пропущено"
        ;;
esac

# 3. Общие кэши
echo ""
echo -e "${YELLOW}🗑️ Общие кэши${NC}"
read -p "Удалить кэши браузеров (Arc, Zen, Google)? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ~/Library/Caches/Arc/*
    rm -rf ~/Library/Caches/zen/*
    rm -rf ~/Library/Caches/Google/*
    echo -e "${GREEN}✅ Кэши браузеров очищены${NC}"
fi

# 4. Homebrew
echo ""
echo -e "${YELLOW}🍺 Homebrew${NC}"
brew cleanup -s 2>/dev/null || true
echo -e "${GREEN}✅ Homebrew очищен${NC}"

# 5. Python кэш
echo ""
echo -e "${YELLOW}🐍 Python кэш${NC}"
find ~/Dev -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
find ~/Dev -name '*.pyc' -delete 2>/dev/null || true
rm -rf ~/Library/Caches/pip/*
echo -e "${GREEN}✅ Python кэш очищен${NC}"

# 6. Node кэш
echo ""
echo -e "${YELLOW}📦 Node.js кэш${NC}"
rm -rf ~/Library/Caches/node-gyp/*
npm cache clean --force 2>/dev/null || true
echo -e "${GREEN}✅ Node кэш очищен${NC}"

# 7. Корзина
echo ""
echo -e "${YELLOW}🗑️ Корзина${NC}"
rm -rf ~/.Trash/*
echo -e "${GREEN}✅ Корзина пуста${NC}"

# 8. Логи
echo ""
echo -e "${YELLOW}📋 Логи${NC}"
rm -rf ~/Library/Logs/*
echo -e "${GREEN}✅ Логи очищены${NC}"

# 9. System caches (требует sudo)
echo ""
echo -e "${YELLOW}🔧 Системные кэши (требует пароль)${NC}"
sudo rm -rf /Library/Caches/*
sudo rm -rf /System/Volumes/Data/Library/Caches/*
echo -e "${GREEN}✅ Системные кэши очищены${NC}"

# Финал
echo ""
echo "======================================"
echo -e "${GREEN}✅ ОЧИСТКА ЗАВЕРШЕНА!${NC}"
echo "======================================"
echo ""
echo -e "${YELLOW}📊 ИТОГИ:${NC}"
echo "Свободно места:"
df -h / | tail -1

echo ""
echo -e "${YELLOW}💡 РЕКОМЕНДАЦИИ:${NC}"
echo "1. Перезагрузи Mac для применения изменений"
echo "2. Настрой Docker: Settings → Resources → Memory: 2GB"
echo "3. Отключи JetBrains Toolbox авто-бэкапы"
