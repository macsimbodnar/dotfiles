# Platform
alias gpu-intel="sudo prime-select intel"
alias gpu-nvidia="sudo prime-select nvidia"
alias python="python3"

# Shell util
alias aliase="vim ~/.bash_aliases"
alias aliasp="alias | awk '{ split(\$2,res,\"=\"); print res[1] }'"
alias reloadp="source ~/.bashrc"

# Code
alias format="astyle --suffix=none --options=.circleci/.astylerc --recursive *.cpp,*.h | grep ^Formatted"
alias check-format="astyle --suffix=none --options=.circleci/.astylerc --recursive --dry-run *.cpp,*.h | grep ^Formatted"

alias fcc="check-format"
alias fpp="format"

alias valg="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-report.txt"

alias set-ass="export ASAN_OPTIONS=detect_leaks=0:halt_on_error=0:strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1 && export ASAN_ENABLED=1"

alias unset-ass="unset ASAN_OPTIONS && unset ASAN_ENABLED"

# Load private
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi