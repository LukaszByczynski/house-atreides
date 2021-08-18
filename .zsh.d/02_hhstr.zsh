export HISTFILE=~/.zsh.d/.zsh_history   # ensure history file visibility
export HSTR_CONFIG=hicolor              # get more colors

alias hh=hstr                             # hh to be alias for hstr
bindkey -s "\C-r" "\eqhstr\n"     # bind hstr to Ctrl-r (for Vi mode check doc)
