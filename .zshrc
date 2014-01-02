
bindkey '^[[A' up-line-or-search                # up arrow for back-history-search
bindkey '^[[B' down-line-or-search              # down arrow for fwd-history-search
bindkey ';5D' backward-word                    # ctrl+left
bindkey ';5C' forward-word                      # ctrl+right
bindkey '\e[1~' beginning-of-line              # home
bindkey '\e[2~' overwrite-mode                  # insert
bindkey '\e[3~' delete-char                    # del
bindkey '\e[4~' end-of-line                    # end
bindkey '\e[5~' up-line-or-history              # page-up
bindkey '\e[6~' down-line-or-history            # page-down

zstyle ':completion:*' insert-tab false        # Автокомплит для первого символа

HISTFILE=~/.zhistory
## Число команд, сохраняемых в HISTFILE
SAVEHIST=5000
## Чucлo команд, coxpaняeмыx в сеансе
HISTSIZE=5000
DIRSTACKSIZE=20
# Опции истории команд
#Добавляет в историю время выполнения команды.
setopt extended_history
alias history='fc -il 1'

#История становится общей между всеми сессиями / терминалами.
setopt share_history

# Дополнение файла истрии
setopt  APPEND_HISTORY

#Добавить команду в историю не после выполнения а перед
setopt INC_APPEND_HISTORY

# Игнopupoвaть вce пoвтopeнuя команд
setopt  HIST_IGNORE_ALL_DUPS

# Удалять из файл истории пустые строки
setopt  HIST_REDUCE_BLANKS

# команды «history» и «fc» в историю заноситься не будут
setopt HIST_NO_STORE 

# если набрали путь к директории без комманды CD, то перейти
setopt AUTO_CD

#Сообщать при изменении статуса фонового задания
setopt NOTIFY

#Перемещение стрелочками по выбору
#setopt menucomplete
#zstyle ':completion:*' menu select=1 _complete _ignored _approximate

#Вести себя как в BASH
setopt AUTO_MENU BASH_AUTO_LIST

# исправлять неверно набранные комманды
setopt CORRECT_ALL
# вопрос на автокоррекцию
SPROMPT='zsh: Заменить '\''%R'\'' на '\''%r'\'' ? [Yes/No/Abort/Edit] '

# загружаем список цветов
autoload colors && colors

#Можно вводить комментарии начинающиеся с #.
setopt interactive_comments

autoload -U compinit promptinit
compinit
promptinit;
#Дополняем спрятанные .файлы:
_comp_options+=(globdots)

# экранируем спецсимволы в url, например &amp;, ?, ~ и так далее
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Включение поддержки выражений вроде «{1-3}» или «{a-d}» — они будут разворачиваться
# в «1 2 3» и «a b c d» соответственно
setopt BRACECCL 

# куда же мы без калькулятора
autoload -U zcalc

if [[ $EUID == 0 ]]
then
#Закорючки %2` означают две директории в пути.
PROMPT=$'%{\e[1;31m%}%n %{\e[1;34m%}%2~%{\e[1;31m%} %#%{\e[0m%} '
else
#PROMPT=$'%{\e[1;32m%}%n %{\e[1;34m%}%~ %#%{\e[0m%} ' # root dir #
PROMPT=$'%{\e[1;31m%}%n %{\e[1;34m%}%2~%{\e[1;31m%} %#%{\e[0m%} '
fi
RPROMPT=$'%{\e[1;30m%}%T% %{\e[1;36m%} %M%{\e[0m%}' # right prompt with time

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias df='df -k --print-type --human-readable' 
alias du='du -k --total --human-readable' 
alias -g  HE='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )' # Highlight Errors

# разукрашиваем команды с помощью grc
if [ -f /usr/bin/grc ]; then
alias ping='grc --colour=auto ping'
alias traceroute='grc --colour=auto traceroute'
alias make='grc --colour=auto make'
alias diff='grc --colour=auto diff»'
alias cvs='grc --colour=auto cvs'
alias netstat='grc --colour=auto netstat'
# разукрашиваем логи с помощью grc
alias logc="grc cat"
alias tail='grc --colour=auto tail -n 200 -f'
alias logh="grc head"
fi

# После перехода в директорию вызываем ls. 
function lcd() {cd "$1" && ls} 

##подключаем всякую фигню

#Красивый вывод mysql
export MYSQL_PS1="mysql: \d|> "
# Необходимо добавить в конфиг Mysql
# [mysql]
# pager  = grcat ~/.grcat 

#Раскраска строки ввода 
source ~/.zsh/zsh-syntax-highlighting.zsh
