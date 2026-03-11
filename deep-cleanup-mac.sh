#!/bin/bash
# Очистка macOS от мусора после удаления приложений

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "======================================"
echo "🧹 ОЧИСТКА MACOS ОТ МУСОРА"
echo "======================================"
echo ""

# 1. Docker Desktop остатки
echo -e "${YELLOW}🐳 Docker Desktop остатки...${NC}"
rm -rf ~/Library/Application\ Support/Docker\ Desktop 2>/dev/null && echo "✅ Docker Desktop Application Support"
rm -rf ~/Library/Caches/com.docker.* 2>/dev/null && echo "✅ Docker Caches"
rm -rf ~/Library/Group\ Containers/group.com.docker 2>/dev/null && echo "✅ Docker Group Containers"
rm -rf ~/Library/Containers/com.docker.docker 2>/dev/null && echo "✅ Docker Containers"
rm -rf ~/Library/Saved\ Application\ State/com.docker.docker.savedState 2>/dev/null && echo "✅ Docker Saved State"
rm -rf ~/Library/LaunchAgents/com.docker.* 2>/dev/null && echo "✅ Docker LaunchAgents"
rm -rf ~/Library/Logs/Docker* 2>/dev/null && echo "✅ Docker Logs"

# 2. JetBrains Toolbox кэш (инсталляторы)
echo -e "${YELLOW}📦 JetBrains Toolbox кэш...${NC}"
rm -rf ~/Library/Caches/JetBrains/Toolbox/download/* 2>/dev/null && echo "✅ JetBrains download cache"
rm -rf ~/Library/Caches/JetBrains/Toolbox/backup/* 2>/dev/null && echo "✅ JetBrains backup cache"

# 3. Homebrew кэш
echo -e "${YELLOW}🍺 Homebrew кэш...${NC}"
brew cleanup -s 2>/dev/null && echo "✅ Homebrew cache cleaned"

# 4. Python кэш
echo -e "${YELLOW}🐍 Python кэш...${NC}"
rm -rf ~/Library/Caches/pip/* 2>/dev/null && echo "✅ pip cache"
rm -rf ~/Library/Caches/gopls/* 2>/dev/null && echo "✅ gopls cache"
find ~/Dev -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null && echo "✅ Python __pycache__"

# 5. Node.js кэш
echo -e "${YELLOW}📦 Node.js кэш...${NC}"
rm -rf ~/Library/Caches/node-gyp/* 2>/dev/null && echo "✅ node-gyp cache"
rm -rf ~/Library/Caches/typescript/* 2>/dev/null && echo "✅ typescript cache"

# 6. Старые логи
echo -e "${YELLOW}📋 Старые логи...${NC}"
rm -rf ~/Library/Logs/* 2>/dev/null && echo "✅ Logs cleaned"

# 7. CrashReporter
echo -e "${YELLOW}💥 CrashReporter...${NC}"
rm -rf ~/Library/Logs/CrashReporter/* 2>/dev/null && echo "✅ CrashReporter cleaned"

# 8. Кэш приложений которых нет
echo -e "${YELLOW}🗑️ Кэш удалённых приложений...${NC}"
rm -rf ~/Library/Caches/com.plausiblelabs.crashreporter.data/* 2>/dev/null
rm -rf ~/Library/Caches/com.klauncher.app.ShipIt/* 2>/dev/null
rm -rf ~/Library/Caches/klauncher-updater/* 2>/dev/null
echo "✅ KLauncher cache"

# 9. GeoServices кэш
echo -e "${YELLOW}🌍 GeoServices кэш...${NC}"
rm -rf ~/Library/Caches/GeoServices/* 2>/dev/null && echo "✅ GeoServices cache"

# 10. Системный кэш
echo -e "${YELLOW}⚙️ Системный кэш...${NC}"
sudo rm -rf /Library/Caches/* 2>/dev/null && echo "✅ System cache cleaned"

echo ""
echo "======================================"
echo -e "${GREEN}✅ ОЧИСТКА ЗАВЕРШЕНА!${NC}"
echo "======================================"
echo ""
echo "📊 Свободно места:"
df -h / | tail -1
