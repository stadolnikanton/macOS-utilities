# Экспорт пути к oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Установите имя темы на пустое, так как используем Starship
ZSH_THEME=""

# Плагины
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

# Алиасы для eza
alias ls="eza --icons"
alias la="eza --icons -la"
alias lt="eza --icons --tree -l"
alias lat="eza --icons --tree -la"
alias cls="clear"
alias py="python3"
alias fetch="fastfetch --config ascii-art"
alias cd="z"
export EDITOR=nvim
# Starship prompt (после oh-my-zsh)
eval "$(starship init zsh)"

# echo "Code can be refactored. Life cannot. Remember that"
echo -e "\n\e[3;33mCode can be refactored. Life cannot. Remember that\e[0m\n"

# ===== PYTHON BACKEND DEV ALIASES =====
alias py="python3"
alias pip="pip3"
alias dev-start="$HOME/bin/dev-services.sh start"
alias dev-stop="$HOME/bin/dev-services.sh stop"
alias dev-status="$HOME/bin/dev-services.sh status"
alias docker-start="$HOME/bin/dev-services.sh docker-on"
alias docker-stop="$HOME/bin/dev-services.sh docker-off"
alias docker-reset="$HOME/bin/dev-services.sh docker-reset"
alias docker-ps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# PostgreSQL helper
alias pg='$HOME/bin/pg-tool.sh connect'
alias pg-ls='$HOME/bin/pg-tool.sh ls'
alias pg-create='$HOME/bin/pg-tool.sh create'
alias pg-drop='$HOME/bin/pg-tool.sh drop'
alias pg-reset='$HOME/bin/pg-tool.sh reset'

# Быстрый запуск проекта django
alias runserver="python3 manage.py runserver"
alias migrate="python3 manage.py migrate"
alias makemigrations="python3 manage.py makemigrations"
alias shell="python3 manage.py shell"
alias dbshell="python3 manage.py dbshell"

# Очистка Python
alias pyclean="find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null; find . -name '*.pyc' -delete 2>/dev/null; echo '✅ Python cache cleaned'"
# Venv
alias venv="python3 -m venv .venv"
alias activate="source .venv/bin/activate"

# Терминалы
alias ghostty="open -a Ghostty"
alias alacritty="open -a Alacritty"

# ===== BROWSERS =====
alias firefox="open -a Firefox"
alias ff="open -a Firefox Developer Edition"
alias chrome="open -a Google Chrome"
alias arc="open -a Arc"
alias safari="open -a Safari"

# ===== OBSIDIAN CLI =====
alias obs="obsidian-cli"
alias obs-open="obs open"
alias obs-create="obs create"
alias obs-search="obs search"
alias obs-list="obs list"
alias obs-daily="obs daily"

# Главное хранилище (iCloud) - полный путь
export OBSIDIAN_VAULT="/Users/duck/Library/Mobile Documents/iCloud~md~obsidian/Documents/Главное хранилище"

alias obs-main="obs --vault \"$OBSIDIAN_VAULT\""
alias obs-main-open="obs open --vault \"$OBSIDIAN_VAULT\""
alias obs-main-create="obs create --vault \"$OBSIDIAN_VAULT\""
alias obs-main-search="obs search --vault \"$OBSIDIAN_VAULT\""
alias obs-main-daily="obs daily --vault \"$OBSIDIAN_VAULT\""
alias obs-main-list="obs list --vault \"$OBSIDIAN_VAULT\""

# ===== PATH FOR DEV =====
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# ===== SYSTEM MONITORING =====
alias htop="btop"
alias top="btop"
alias monitor="btop"
alias sysmon="~/bin/sysmon.sh"

autoload -Uz add-zsh-hook
