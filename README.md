# My dot files


## Claude Code

Global config in `claude/`, installed into `~/.claude` (all projects, Linux and macOS):
* `CLAUDE.md`: global rules loaded at the start of every session.
* `statusline.sh`: two line status bar at the bottom of the session.
* `settings.json`: keys merged into `~/.claude/settings.json` (registers the status line).

### To configure Claude Code:
* Install `jq` (`sudo apt install jq` or `brew install jq`).
* `./claude/install.sh`

Symlinks `CLAUDE.md` and `statusline.sh`, merges `settings.json`. Safe to re-run;
anything it replaces is kept as `<name>.bak.<timestamp>`.

Verify with `/context` in a session — `CLAUDE.md` should appear under **Memory files**.

### Status line
```
Opus 5.5 · dotfiles ⎇ master* · ctx ███████░░░ 68% 136k/200k
5h ████│░░░░░ 41% ↻18:40   7d ██░░│░░░░░ 22% ↻Thu 09:00
```
* `ctx`: context window used, tokens used / window size.
* `5h`: current session limit, `7d`: weekly limit. Same numbers as `/usage`.
  Pro/Max plans only, shown after the first reply of a session. `↻` is reset time.
* `│`: even pacing. Fill past it means you burn the limit faster than it resets.
* Colors: green under 60%, yellow under 80%, red from 80%.

## Vim

### To configure vim:
* `ln -s .vimrc ~/.vimrc`
* `git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim`
* `git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree`
* `git clone git@github.com:vim-airline/vim-airline.git ~/.vim/bundle/vim-airline`

### Hot keys
* `Ctrl + n`: toggle NERDTree
* `I`:        toggle NERDTree hidden files
* `Ctrl + w Ctrl + w`: Switch tab
