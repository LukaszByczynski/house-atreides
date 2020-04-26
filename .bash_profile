if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH="$HOME/.cargo/bin:$PATH"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
