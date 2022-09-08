#### Wellcome message
set -g -x fish_greeting 'Hey cutie'

set -g EDITOR vim

##### Aliases

# Public
alias pip="pip3"
alias python="python3"
alias list-source-files="find . -iname '*.h' -o -iname '*.c' -o -iname '*.hpp' -o -iname '*.cpp'"
alias format="list-source-files | xargs clang-format -i"
alias check-format="list-source-files | xargs clang-format --dry-run -Werror"

alias fcc="check-format"
alias fpp="format"

alias valg="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-report.txt"

alias set-ass="export ASAN_OPTIONS=detect_leaks=0:halt_on_error=0:strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1; export ASAN_ENABLED=1"

alias unset-ass="set -e ASAN_OPTIONS ; set -e ASAN_ENABLED"

alias vasm="~/ws/vasm/vasm6502_oldstyle"

alias sysinfo="neofetch"

alias count-dir="ls -l ./ | grep -c ^d"

alias lines-of-code="cloc ."

alias build="rm -rf build && mkdir build && cd build"
alias rebuild="cd .. && rm -rf build && mkdir build && cd build"

alias do-tar="tar -czf"
alias undo-tar="tar -xzf"

# Sourece non public shit
if test -e ~/.config/fish/private_config.fish
    source ~/.config/fish/private_config.fish
end
