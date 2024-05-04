# Based on bira zsh theme with nvm, rvm and jenv support

function kubectl_prompt_info() {
  which kubectl &>/dev/null || return
  K8S_CONTEXT="$(kubectl config current-context)"
  K8S_NS="$(kubectl config view --minify -o jsonpath="{..namespace}")"
  echo "${ZSH_THEME_K8S_PROMPT_PREFIX}${K8S_CONTEXT}:${K8S_NS}${ZSH_THEME_K8S_PROMPT_SUFFIX}"
}

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'

local pyenv_py='%{$fg[cyan]%}$(virtualenv_prompt_info)%{$reset_color%}'
local kubectl='%{$fg[blue]%}$(kubectl_prompt_info)%{$reset_color%}'
local aws_info='%{$fg[yellow]%}$(aws_prompt_info)%{$reset_color%}'

local git_branch='$(git_prompt_info)'

function print_line() {
  echo -n '%(?.%{$fg[green]%}.%{$fg[red]%})'
  for i in {1..$COLUMNS}; do printf "-"; done
  echo -n '%{$reset_color%}'
  echo ""
}

build_prompt_info() {
  print_line
  echo -n '╭─ '
  if [ "$DEFAULT_USER" != "$USER" ]; then
    echo -n "${user_host} "
  fi
  echo -n "${current_dir} "
  echo -n "${git_branch}"
  echo -n "${pyenv_py}"
  echo -n "${kubectl}"
  echo -n "${aws_info}"
  echo -n '\n'
  echo -n '╰─ '
  echo -n '%B[%T] %#%b '
}

PROMPT="$(build_prompt_info)"
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹ "
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_NVM_PROMPT_PREFIX="‹ "
ZSH_THEME_NVM_PROMPT_SUFFIX="› "
ZSH_THEME_VIRTUALENV_PREFIX="‹ "
ZSH_THEME_VIRTUALENV_SUFFIX="› "
ZSH_THEME_AWS_PROFILE_PREFIX="‹󰸏 "
ZSH_THEME_AWS_PROFILE_SUFFIX="› "
ZSH_THEME_K8S_PROMPT_PREFIX="‹󱃾 "
ZSH_THEME_K8S_PROMPT_SUFFIX="› "
