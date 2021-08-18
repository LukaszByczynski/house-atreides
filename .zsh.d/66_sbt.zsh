# SBT
SBT_OPTS=$(<$HOME/.sbtopts)
SBT_OPTS="${SBT_OPTS//$'\n'/ }"
export SBT_OPTS="$SBT_OPTS"
