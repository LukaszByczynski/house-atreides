if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
source "$HOME/.cargo/env"
