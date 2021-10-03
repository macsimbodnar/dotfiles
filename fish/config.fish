#### Wellcome message
set -g -x fish_greeting 'Hey cutie'

set -eg EDITOR vim

##### Aliases

# Public
alias pip="pip3"
alias python="python3"
alias format="astyle --suffix=none --options=$HOME/.astylerc --recursive '*.cpp,*.h,*.hpp' | grep '^Formatted'"
alias check-format="astyle --suffix=none --options=$HOME/.astylerc --recursive --dry-run '*.cpp,*.h,*.hpp' | grep '^Formatted'"

alias local-check-format="astyle --suffix=none --options=./.circleci/.astylerc --recursive --dry-run '*.cpp,*.h,*.hpp' | grep '^Formatted'"
alias local-format="astyle --suffix=none --options=./.circleci/.astylerc --recursive '*.cpp,*.h,*.hpp' | grep '^Formatted'"

alias fcc="check-format"
alias fpp="format"
alias lfcc="local-check-format"
alias lfpp="local-format"

alias valg="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-report.txt"

alias set-ass="export ASAN_OPTIONS=detect_leaks=0:halt_on_error=0:strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1; export ASAN_ENABLED=1"

alias unset-ass="set -e ASAN_OPTIONS ; set -e ASAN_ENABLED"

alias scan="clamscan -r --bell -i"

alias penv="source venv/bin/activate"

alias makes="make clean ; make all -j(getconf _NPROCESSORS_ONLN) ; make test -j(getconf _NPROCESSORS_ONLN)"

alias vasm="~/ws/vasm/vasm6502_oldstyle"

alias sysinfo="neofetch"

alias count-dir="ls -l ./ | grep -c ^d"

alias lines-of-code="cloc ."

alias build="rm -rf build && mkdir build && cd build"
alias rebuild="cd .. && rm -rf build && mkdir build && cd build"

# Sourece non public shit
if test -e ~/.config/fish/private_config.fish
    source ~/.config/fish/private_config.fish
end
