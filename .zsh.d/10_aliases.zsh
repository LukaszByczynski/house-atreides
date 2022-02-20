# ALIASES
alias ff=fzf
alias vs="code ."
alias sm="smerge ."
alias bs="brew services start scalacenter/bloop/bloop"
alias bh="brew services stop scalacenter/bloop/bloop"
alias m_import="rm -rf .bloop .metals; sbt bloopInstall"
alias m_rmmetals="rm -rf .bloop .metals"
alias m_rmtarget="find . -type d -name target -exec rm -rf {} \;"
alias m_rmnode="rm -rf .nuxt node_modules yarn.lock"
alias vi=nvim
alias ls=exa
