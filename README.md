# My dot files


## Claude Code

Global rules loaded at the start of every session, in every project.

### To configure Claude Code:
* `mkdir -p ~/.claude`
* `ln -s ~/ws/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md`

Verify with `/context` in a session — `CLAUDE.md` should appear under **Memory files**.

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
