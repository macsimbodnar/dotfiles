#!/usr/bin/env bash
# Claude Code status line. Claude Code pipes session JSON on stdin.
# Fields: https://code.claude.com/docs/en/statusline
#
#   Opus 5.5 · dotfiles ⎇ master* · ctx ███████░░░ 68% 136k/200k
#   5h ████│░░░░░ 41% ↻18:40   7d ██░░│░░░░░ 22% ↻Thu 09:00
#
# One line (context left, usage right-aligned) when the terminal is wide
# enough, else the two lines above.
#
# Bars: green <60%, yellow <80%, red >=80%. The │ marks even pacing: where usage
# would be if spread evenly over the window. Fill past it = burning too fast.
# Must stay bash 3.2 compatible (macOS /bin/bash).

if ! command -v jq >/dev/null 2>&1; then
    echo "statusline: jq not found (apt install jq | brew install jq)"
    exit 0
fi

# One jq call for everything. Reset times and pacing are computed in jq so no
# GNU vs BSD `date` differences. Absent fields come out as empty strings: they
# are null early in a session, and rate_limits only exist on Pro/Max plans.
vars=$(jq -r '
    def opt(f): if . == null then "" else f end;
    def tok: if . >= 1000000 then "\(. / 100000 | round / 10)M"
             elif . >= 1000 then "\(. / 1000 | round)k"
             else tostring end;
    # Percent of the window already elapsed, for the pacing marker.
    def pace($window): (now - (. - $window)) / $window * 100
                       | if . < 0 then 0 elif . > 100 then 100 else floor end;
    .context_window as $cw
    | .rate_limits.five_hour as $h
    | .rate_limits.seven_day as $w
    | @sh "model=\(.model.display_name // "?")",
      @sh "cwd=\(.workspace.current_dir // .cwd // "")",
      @sh "ctx_pct=\($cw.used_percentage | opt(round))",
      @sh "ctx_used=\($cw.total_input_tokens | opt(tok))",
      @sh "ctx_size=\($cw.context_window_size | opt(tok))",
      @sh "h_pct=\($h.used_percentage | opt(round))",
      @sh "h_pace=\($h.resets_at | opt(pace(18000)))",
      @sh "h_reset=\($h.resets_at | opt(strflocaltime("%H:%M")))",
      @sh "w_pct=\($w.used_percentage | opt(round))",
      @sh "w_pace=\($w.resets_at | opt(pace(604800)))",
      @sh "w_reset=\($w.resets_at | opt(strflocaltime("%a %H:%M")))"
') || { echo "statusline: jq could not parse the session JSON"; exit 0; }
eval "$vars"

RESET=$'\033[0m'
DIM=$'\033[2m'
BOLD=$'\033[1m'
CYAN=$'\033[36m'
BLUE=$'\033[34m'
MAGENTA=$'\033[35m'

pct_color() {
    if [ -z "$1" ]; then printf '%s' "$DIM"
    elif [ "$1" -lt 60 ]; then printf '\033[32m'
    elif [ "$1" -lt 80 ]; then printf '\033[33m'
    else printf '\033[31m'
    fi
}

# bar PCT [PACE] -> 10 cell bar, optional pacing marker. Empty PCT = empty bar.
bar() {
    local pct=$1 pace=$2 width=10 filled=0 mark=-1 color out="" i
    if [ -n "$pct" ]; then
        filled=$(( (pct * width + 50) / 100 ))
        [ "$filled" -gt "$width" ] && filled=$width
    fi
    if [ -n "$pace" ]; then
        mark=$(( pace * width / 100 ))
        [ "$mark" -ge "$width" ] && mark=$((width - 1))
    fi
    color=$(pct_color "$pct")
    for ((i = 0; i < width; i++)); do
        if [ "$i" -eq "$mark" ]; then out+="${BOLD}│${RESET}"
        elif [ "$i" -lt "$filled" ]; then out+="${color}█${RESET}"
        else out+="${DIM}░${RESET}"
        fi
    done
    printf '%s' "$out"
}

# pct_label PCT -> "41%" colored, or dim "--" when unknown.
pct_label() {
    if [ -z "$1" ]; then printf '%s--%s' "$DIM" "$RESET"
    else printf '%s%s%%%s' "$(pct_color "$1")" "$1" "$RESET"
    fi
}

# limit LABEL PCT PACE RESET -> one rate limit segment.
limit() {
    printf '%s %s %s' "$1" "$(bar "$2" "$3")" "$(pct_label "$2")"
    [ -n "$4" ] && printf ' %s↻%s%s' "$DIM" "$4" "$RESET"
}

dir=${cwd##*/}
[ "$cwd" = "$HOME" ] && dir="~"
[ -z "$dir" ] && dir="/"

git_part=""
if branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null); then
    # --no-optional-locks: do not take index.lock and race with the user's git.
    [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null | head -n 1)" ] && branch+="*"
    git_part=" ${MAGENTA}⎇ ${branch}${RESET}"
fi

tokens=""
[ -n "$ctx_used" ] && [ -n "$ctx_size" ] && tokens=" ${DIM}${ctx_used}/${ctx_size}${RESET}"

left=$(printf '%s%s%s · %s%s%s%s · ctx %s %s%s' \
    "$CYAN" "$model" "$RESET" "$BLUE" "$dir" "$RESET" "$git_part" \
    "$(bar "$ctx_pct")" "$(pct_label "$ctx_pct")" "$tokens")
right=$(printf '%s   %s' \
    "$(limit 5h "$h_pct" "$h_pace" "$h_reset")" \
    "$(limit 7d "$w_pct" "$w_pace" "$w_reset")")

# Columns on screen: drop ANSI codes, then count only UTF-8 lead bytes, so the
# result does not depend on the locale bash or wc run under.
vis_width() {
    printf '%s' "$1" | LC_ALL=C sed $'s/\033\\[[0-9;]*m//g' | LC_ALL=C tr -d '\200-\277' | wc -c
}

# COLUMNS is the full terminal width, but Claude Code indents the status line,
# so keep a margin or the right side wraps. No COLUMNS (manual run) = two lines.
margin=4
min_gap=3
gap=$(( ${COLUMNS:-0} - margin - $(vis_width "$left") - $(vis_width "$right") ))
if [ "$gap" -ge "$min_gap" ]; then
    printf '%s%*s%s\n' "$left" "$gap" "" "$right"
else
    printf '%s\n%s\n' "$left" "$right"
fi
