
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '{28}●'
zstyle ':vcs_info:*' unstagedstr '{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b{1}:{11}%r'
zstyle ':vcs_info:*' enable git
precmd () {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats ' [%b%c%u]'
  } else {
    zstyle ':vcs_info:*' formats ' [%b%c%u●]'
  }

  vcs_info
}


setopt prompt_subst
RPROMPT=' ${vcs_info_msg_0_} %(?//) '



