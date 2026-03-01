#!/bin/bash
# Управление dev-сервисами для Python backend (Colima + native)

case "$1" in
    start)
        echo "🚀 Запуск dev-сервисов..."
        brew services start postgresql@14
        brew services start redis
        echo "✅ PostgreSQL и Redis запущены"
        ;;
    stop)
        echo "🛑 Остановка dev-сервисов..."
        brew services stop postgresql@14
        brew services stop redis
        echo "✅ Сервисы остановлены"
        ;;
    status)
        echo "📊 Статус сервисов:"
        brew services list | grep -E "postgresql|redis|colima"
        echo ""
        echo "🐳 Docker (Colima):"
        colima status 2>/dev/null || echo "  Не запущен"
        echo ""
        echo "📊 Память:"
        ps aux | grep -E "postgres|redis|docker|qemu" | grep -v grep | awk '{sum+=$4} END {print "RAM: " sum "%"}'
        ;;
    docker-on)
        echo "🐳 Запуск Docker (Colima)..."
        colima start --cpu 2 --memory 2 --disk 10
        echo "✅ Docker запущен (2 CPU, 2GB RAM, 10GB диск)"
        ;;
    docker-off)
        echo "🐳 Остановка Docker..."
        colima stop
        echo "✅ Docker остановлен"
        ;;
    docker-reset)
        echo "🔄 Сброс Docker..."
        colima delete
        colima start --cpu 2 --memory 2 --disk 10
        echo "✅ Docker сброшен"
        ;;
    *)
        echo "Использование: $0 {start|stop|status|docker-on|docker-off|docker-reset}"
        echo ""
        echo "Примеры:"
        echo "  $0 start       - Запустить PostgreSQL и Redis"
        echo "  $0 stop        - Остановить PostgreSQL и Redis"
        echo "  $0 status      - Показать статус всех сервисов"
        echo "  $0 docker-on   - Запустить Docker (Colima)"
        echo "  $0 docker-off  - Остановить Docker"
        echo "  $0 docker-reset - Полный сброс Docker"
        ;;
esac
