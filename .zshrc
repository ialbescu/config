#########################
# 0. Get platform type  #
#########################
if [[ "`uname`" == "Darwin" ]];then
  platform='mac'
else
  platform='linux'
fi


################
# 1. Les alias #
################

# Gestion du 'ls' : couleur & ne touche pas aux accents
#LINUX
if [[ "$platform" == "linux" ]];then
  alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
  alias vi='gvim'
  alias grep='grep --color -n'
fi

#MAC
if [[ "$platform" == "linux" ]];then
  alias ls='ls -G'
  #alias vi='mvim'
  alias grep='grep --color=always -n'
  function tabtitle {
    echo -ne "\e]1;$1\a"
  }
fi

# Demande confirmation avant d'écraser un fichier

# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'
alias m='mutt -y'
alias md='mkdir'
alias rd='rmdir'
alias upgrade='apt-get update && apt-get upgrade && apt-get clean'

# Arnaud alias
alias rd='rdesktop -g 1600x980 -k fr'
alias gvim='gvim --remote-silent'
alias mvim='/Applications/MacVim-snapshot-70/mvim --remote-silent'
alias pep8='ltu-style-check'

#Git alias
alias gpull='git pull origin master'
alias gpullr='git pull --rebase origin master'
alias gri='git rebase --interactive'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit --amend'
alias g_push='git push origin HEAD:refs/for/master'
alias gpush=git_push $1
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --color'
alias gclone=git_clone $1
alias glb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches"
alias fuck="git reset --soft HEAD@{1}"

# Docker alias
alias dmacinit='$(boot2docker shellinit)'
alias dlist='docker images'
alias drun=docker_run $1

#Caladan Alias
alias video_update="curl --data-binary '{ \"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.Scan\", \"id\": \"mybash\"}' -H 'content-type: application/json;' http://localhost:8080/jsonrpc"

#LTU Alias
alias inttest='nosetests -v --log-config=python/ltu/saas/test_data/logging.conf --with-xunit --xunit-file=integration.xml -m "(_test\.)|(test[^\.]*$)" -a integration_test --no-skip python/ltu'
alias inttest='for python_module in `find ./python/ltu -name "*_test.py"`;do echo $python_module;nosetests -v --log-config=python/ltu/saas/test_data/logging.conf --with-xunit --xunit-file=integration.xml -m "(_test\.)|(test[^\.]*$)" -a integration_test --no-skip $python_module;if [[ $? != 0 ]];then break;else date;fi;done'
alias hook='scp -p -P 29418 git.corp.ltutech.com:hooks/commit-msg .git/hooks/'
alias win='rdesktop -g 1600x980 -k fr 10.1.10.208&'
alias cleanDBEnv='python -m ltu.saas.testing.regression.ltucommands'
alias lm='/cvs/devContribs/flexlm/v11.7_lsb_x64/x64_lsb/lmcrypt'

#######################################
# 2. Prompt et définition des touches #
#######################################

# Exemple : ma touche HOME, cf  man termcap, est codifiee K1 (upper left
# key  on keyboard)  dans le  /etc/termcap.  En me  referant a  l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis :  K1=\E[1~, c'est la sequence  de caracteres qui sera  envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Correspondance touches-fonction
bindkey -v
bindkey ''    beginning-of-line       # Home
bindkey ''    end-of-line             # End
bindkey ''    delete-char             # Del
bindkey '^[[1~' beginning-of-line       # Home
bindkey '^[[4~' end-of-line             # End
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn
bindkey "\Cr"   history-incremental-search-backward





# Prise en charge des touches [début], [fin] et autres
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char


# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  else
    eval "`dircolors`"
  fi
fi


###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
unsetopt clobber
# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct
# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
#setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
#unsetopt list_ambiguous
# (Merci à Youri van Rietschoten de m'avoir donné l'info !)

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash
# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup


###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

# Nombre d'entrées dans l'historique
export HISTORY=10000
export HISTSIZE=10000
export SAVEHIST=10000

# Fichier où est stocké l'historique
export HISTFILE=$HOME/.history

# Ajoute l'historique à la fin de l'ancien fichier
setopt append_history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
#setopt hist_ignore_all_dups

# Supprime les  répétitions dans l'historique lorsqu'il  est plein, mais
# pas avant
setopt hist_expire_dups_first

# N'enregistre  pas plus d'une fois  une même ligne, quelles  que soient
# les options fixées pour la session courante
#setopt hist_save_no_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups
setopt SHARE_HISTORY


###########################################
# 5. Complétion des options des commandes #
###########################################

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

autoload -U compinit
compinit

###########################################
# 6. LTU Functions                        #
###########################################

# allows to grep the parameter in any python file
function pygrep(){
  SEARCH_PATH="."
  [ $# -gt 1 ] && SEARCH_PATH=$2
  find $SEARCH_PATH -name "*.py" -not -path "./env/*" -and -not -path "./*egg*/*" -exec egrep --color -in $1 {} +
}

function trace_70 {
  root_folder=`pwd`
  if [ $# != 2 ];then
    echo "Usage: bounce_70 path_to_ref patch_to_query"
    exit 1
  fi
  cd /team/pdv/builds/LtuCore/latest/linux64_Debian/
  cd Content/
  source bashrc.ltucore.conf.runtime -64
  if [ ! -d /tmp/distance ];then
    mkdir /tmp/distance
  fi
  cd /tmp/distance
  /team/pdv/builds/LtuCore/latest/linux64_Debian/Content/distance/bin64/linux/main_testDistance_bin -1 $root_folder/$1 -2 $root_folder/$2 -s 70.1.1 -a 70.2.1 -V lb
  cd $root_folder
  display /tmp/distance/lines.png&
  display /tmp/distance/boxes.png&
}

function git_clone {
   if [ $# != 1 ];then
    echo "Usage: git_clone repo_path"
    exit 1
  fi
  git clone ssh://git.corp.ltutech.com:29418/${1}
}

function git_push {
  if [ $# != 1 ];then
    echo "Please provide reviewers like this: alamy,rparent."
  fi
  reviewers=""
  for i in {1..10};do
    reviewer=`echo $1, | cut -d, -f $i -s`
    if [ $reviewer ];then
      reviewers="${reviewers} --reviewer=${reviewer}@ltutech.com"
    else
      break
    fi
  done
  git push origin HEAD:refs/publish/master --receive-pack="git receive-pack ${reviewers}"
}

function get_submodule_commit {
  rm -rf /tmp/submodule
  mkdir -p /tmp/submodule
  cd /tmp/submodule
  git clone ssh://git.corp.ltutech.com:29418/product/engine
  project=`git checkout $1 | sed 's/.*Project: \(.*\)  .*/\1/'`
  cd engine/$project
  commit_id=`git log | head -1 | sed 's/commit //g'`
  git show $commit_id

}

##########################################
# 7. Env                                 #
##########################################

export CVSROOT=:pserver:alamy@cvs.corp.ltutech.com:/cvs/projects/LTU_CVS
export TEAMPDV=/team/pdv
export PATH=$HOME/.local/bin:/cvs/devContribs/linux/jdk1.6.0_02/bin:$PATH
export JAVA_HOME=/cvs/devContribs/linux/jdk1.6.0_02

##########################################
# 8. Git                                 #
##########################################

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{28}● '
zstyle ':vcs_info:*' unstagedstr '%F{11}● '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git
precmd () {
  if [ `echo $PWD | grep 'src' | wc -l` -eq 1 ];then
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
      zstyle ':vcs_info:*' formats "%{$reset_color%}[%F{green}%b%c%u%F{white}]%{$reset_color%}"
    } else {
      zstyle ':vcs_info:*' formats "%{$reset_color%}[%F{green}%b%c%u%F{red}● %F{white}]%{$reset_color%}"
    }

    vcs_info
  fi
}

setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'

# Prompt couleur (la couleur n'est pas la même pour le root et
# pour les simples utilisateurs)

if [ "`id -u`" -eq 0 ]; then
  export PROMPT="%{$reset_color%}%{[36;1m%}%T %{[34m%}%n%{[33m%}@%{[37m%}%m %{[32m%}%~ %{[33m%}%#%{[0m%} %{$reset_color%}"
else
  export PROMPT="%{[36;1m%}%T %{[31m%}%n%{[36;1m%}|%{[33m%}%m %{[32m%}%~%{[33m%} %{[33m%}%#%{[0m%}% %{$reset_color%}%  "
fi

##############################################
# 9. Docker                                  #
##############################################

if [[ "$platform" == "mac" ]];then
    $(boot2docker shellinit >/dev/null 2>&1)
fi
docker_run() {
  docker run -it $1 bash
}
