#!/bin/bash
# Минималистичный мониторинг системы

echo "╭────────────────────────────────────────────╮"
echo "│  📊 SYSTEM MONITOR - MacBook Air M1       │"
echo "╰────────────────────────────────────────────╯"
echo ""

# CPU
echo "🔹 CPU (Apple M1)"
top -l 1 | grep "CPU usage" | awk '{print "   " $3 " user, " $5 " sys, " $7 " idle"}'
echo ""

# Память
echo "🔹 Память"
vm_stat | awk '/Pages active/ {active=$3} /Pages wired/ {wired=$3} /Pages speculative/ {spec=$3} /Pages free/ {free=$3} END {
    total=(active+wired+spec+free)*4/1024;
    used=(active+wired)*4/1024;
    printf "   Использовано: %.2f MB / %.2f MB (%.1f%%)\n", used, total, (used/total)*100
}'
echo ""

# Диск
echo "🔹 Диск"
df -h / | tail -1 | awk '{printf "   Использовано: %s / %s (%s)\n", $3, $2, $5}'
echo ""

# Топ процессов
echo "🔹 Топ 5 процессов (CPU)"
ps aux | sort -nr -k3 | head -5 | awk '{printf "   %-20s %5s%%\n", $11, $3}'
echo ""

# Docker/Colima
echo "🔹 Сервисы"
if colima status 2>/dev/null | grep -q "Running"; then
    echo "   🐳 Docker: запущен"
else
    echo "   🐳 Docker: остановлен"
fi

if brew services list 2>/dev/null | grep -q "postgresql.*started"; then
    echo "   🐘 PostgreSQL: запущен"
else
    echo "   🐘 PostgreSQL: остановлен"
fi

if brew services list 2>/dev/null | grep -q "redis.*started"; then
    echo "   🔴 Redis: запущен"
else
    echo "   🔴 Redis: остановлен"
fi

echo ""
echo "╭────────────────────────────────────────────╮"
echo "│  Для полного мониторинга: btop             │"
echo "╰────────────────────────────────────────────╯"
