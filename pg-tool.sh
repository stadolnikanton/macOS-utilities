#!/bin/bash
# PostgreSQL helper - создание, удаление, подключение к базам

case "$1" in
    create)
        if [ -z "$2" ]; then
            echo "❌ Укажи имя базы: $0 create <dbname>"
            exit 1
        fi
        createdb "$2" && echo "✅ База '$2' создана"
        ;;
    drop)
        if [ -z "$2" ]; then
            echo "❌ Укажи имя базы: $0 drop <dbname>"
            exit 1
        fi
        dropdb "$2" && echo "✅ База '$2' удалена"
        ;;
    connect|c|"")
        if [ -z "$2" ]; then
            pgcli postgres://duck@localhost/postgres
        else
            pgcli "postgres://duck@localhost/$2"
        fi
        ;;
    ls)
        psql -d postgres -c "\l"
        ;;
    reset)
        if [ -z "$2" ]; then
            echo "❌ Укажи имя базы: $0 reset <dbname>"
            exit 1
        fi
        echo "⚠️  Пересоздать базу '$2'? (y/N)"
        read -r confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            dropdb --if-exists "$2"
            createdb "$2"
            echo "✅ База '$2' пересоздана"
            pgcli "postgres://duck@localhost/$2"
        else
            echo "❌ Отменено"
        fi
        ;;
    *)
        echo "PostgreSQL helper"
        echo ""
        echo "Использование: $0 {create|drop|connect|ls|reset}"
        echo ""
        echo "Команды:"
        echo "  create <dbname>   - Создать базу"
        echo "  drop <dbname>     - Удалить базу"
        echo "  connect <dbname>  - Подключиться (или c <dbname>)"
        echo "  ls                - Список всех баз"
        echo "  reset <dbname>    - Пересоздать базу"
        echo ""
        echo "Примеры:"
        echo "  $0 create mydb"
        echo "  $0 c mydb"
        echo "  $0 reset testdb"
        ;;
esac
